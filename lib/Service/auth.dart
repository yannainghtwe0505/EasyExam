import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? loginToken;
//  static String? _token;
  DateTime? _expiryDate;
  String? userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        loginToken != null) {
      return loginToken;
    }
    return null;
  }

  /*ログイン機能*/
  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  /*Apiからログインデータを呼び出して入力した値と確認する機能*/
  Future<void> _authenticate(String email, String password) async {
    final url = Uri.parse("https://localhost:7001/api/Login");
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'loginId': email,
          'password': password,
        }),
      );
      // print(response.body);
      final responseData = json.decode(response.body);


      /*responseData が null でない場合は、認証の値を割り当てます*/
      loginToken = responseData["token"];
      userId = responseData["loginId"];
      _expiryDate = DateTime.now().add(
        const Duration(
          seconds: 10,
        ),
      );

      /*開始からの時間を振り返る*/
      _autoLogout();
      /*終了*/

      /*プロバイダーの変更を行う*/
      notifyListeners();
      /*終了*/

      /*自動ログインのためにデータをメモリに保持する*/
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues({});
      final preference = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': loginToken,
          'userId': userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      preference.setString('userData', userData);
      /*終了*/

    } catch (error) {
      rethrow;
    }
  }

  /*ログアウト機能*/
  Future<void> logout() async {
    loginToken = null;
    userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("userData");
    preferences.clear();
  }
  /*終了*/

  /*自動ログイン機能*/
  Future<bool> tryAutoLogin() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(preferences.getString('userData')) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    loginToken = extractedUserData['token'] as String;
    userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }
  /*終了*/

  /*開始からの時間を振り返る*/
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
  /*終了*/

}
