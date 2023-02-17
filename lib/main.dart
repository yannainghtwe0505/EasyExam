import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_education/Service/api_service.dart';
import 'package:security_education/screens/login.dart';
import 'package:security_education/screens/master_screen.dart';
import 'package:security_education/screens/splash_screen.dart';
import 'package:security_education/screens/test_api_screen.dart';
import 'package:security_education/screens/test_screen.dart';
import 'package:security_education/screens/test_detail_screen.dart';

import 'Service/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    FutureBuilder autoLoginOrLogin(Auth auth) {
      return FutureBuilder(
          future: auth.tryAutoLogin(),
          builder: (context, authResultSnap) =>
              authResultSnap.connectionState == ConnectionState.waiting
                  ? SplashScreen()
                  : Login());
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, ApiService>(
            update: (context, auth, previous) =>
                ApiService(auth.loginToken, auth.userId)),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: const TextTheme(
                  headline6: TextStyle(
                color: Colors.white,
              ))),
          initialRoute: "/",
          routes: {
            "/": (ctx) =>
                auth.isAuth ? const MasterScreen() : autoLoginOrLogin(auth),
            MasterScreen.routeName: (ctx) =>
                auth.isAuth ? const MasterScreen() : autoLoginOrLogin(auth),
            TestScreen.routeName: (ctx) =>
                auth.isAuth ? const TestScreen() : autoLoginOrLogin(auth),
            TestDetailScreen.routeName: (ctx) =>
                auth.isAuth ? const TestDetailScreen() : autoLoginOrLogin(auth),
            TestAPI.routeName: (ctx) =>
                auth.isAuth ? const TestAPI() : autoLoginOrLogin(auth),
          },
        ),
      ),
    );
  }
}
