import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_education/Service/auth.dart';
import 'package:security_education/screens/master_screen.dart';
import 'package:security_education/Utils/media_query.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String userNameHint = "ユーザー名";
  String passwordHint = "パスワード";
  bool init = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget _textWidget(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: Colors.white),
    );
  }

  InputDecoration decorationClass(String text, double fontSize, Color color) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      hintStyle: TextStyle(
          color: color, fontWeight: FontWeight.bold, fontSize: fontSize),
      alignLabelWithHint: true,
      hintText: text,
    );
  }

  Future<void> _saveForm() async {
    await Provider.of<Auth>(context, listen: false)
        .login(userNameController.text, passwordController.text);

    var a = Provider.of<Auth>(context, listen: false).isAuth;
    if (a) {
      Navigator.of(context).pushReplacementNamed(MasterScreen.routeName);
    }

    /** Error Handling  */
    // print(a);
    // if (a) {
    // } else {
    //   showDialog<String>(
    //       context: context,
    //       builder: (BuildContext context) => AlertDialog(
    //             title: const Text(
    //               'ログインできない',
    //               style: TextStyle(color: Colors.black),
    //             ),
    //             content: const Text('このユーザー名とパスワードが登録されていません。'),
    //             actions: <Widget>[
    //               TextButton(
    //                 onPressed: () => Navigator.pop(context, 'OK'),
    //                 child: const Text('OK'),
    //               ),
    //             ],
    //           ));
    // }
  }

  void nodeListener() {
    _userNameFocusNode.addListener(() {
      setState(() {
        if (_userNameFocusNode.hasFocus) {
          userNameHint = '';
        } else {
          userNameHint = 'ユーザー名';
        }
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        if (_passwordFocusNode.hasFocus) {
          passwordHint = '';
        } else {
          passwordHint = 'パスワード';
        }
      });
    });
  }

  @override
  void initState() {
    _getData();
    init = true;
    nodeListener();
    super.initState();
    init = false;
  }

  @override
  void didChangeDependencies() {
    init = false;
    nodeListener();
    super.didChangeDependencies();
  }

  void _getData() async {
    // _loginModel = (await LoginService().getUsers());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.mediaWidth;
    final screenHeight = context.mediaHeight;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              ClipRRect(
                child: Image.asset(
                  "assets/images/mb-login-bg.jpg",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            _textWidget("セキュリティ", 30),
                            _textWidget("教育", 90),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 40),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: userNameController,
                                // initialValue: _initValues['userName'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: decorationClass(
                                    userNameHint, 20, Colors.white),
                                textInputAction: TextInputAction.next,
                                focusNode: _userNameFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              TextFormField(
                                controller: passwordController,
                                // initialValue: _initValues['password'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: decorationClass(
                                    passwordHint, 20, Colors.white),
                                textInputAction: TextInputAction.next,
                                focusNode: _passwordFocusNode,
                                onFieldSubmitted: (value) => _saveForm(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        SizedBox(
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.07,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, //background color of button
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: (userNameController.text != "" &&
                                      passwordController.text != "")
                                  ? () => _saveForm()
                                  : null,
                              // onPressed: () {
                              //   LoginService().login(userNameController.text,
                              //       passwordController.text);
                              // },
                              child: const Text(
                                "ロジック",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenHeight * 0.04),
                          child: const Text(
                            "パスワードを忘れた場合",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  // SizedBox(
                  //   height: screenHeight * 0.1,
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  //   child: Column(
                  //     children: [
                  //       _textFieldWidget("ユーザー名", 20, Colors.white),
                  //       _textFieldWidget("パスワード", 20, Colors.white)
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: screenHeight * 0.1,
                  // ),
                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       width: screenWidth * 0.7,
                  //       height: screenHeight * 0.07,
                  //       child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor:
                  //                 Colors.white, //background color of button
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(8)),
                  //           ),
                  //           onPressed: () => _login(context),
                  //           child: const Text(
                  //             "ロジック",
                  //             style: TextStyle(
                  //               color: Colors.blue,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 22,
                  //             ),
                  //           )),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.all(screenHeight * 0.04),
                  //       child: const Text(
                  //         "パスワードを忘れた場合",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           decoration: TextDecoration.underline,
                  //           decorationThickness: 1.5,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              )
            ],
          ),
        ));
  }
}
