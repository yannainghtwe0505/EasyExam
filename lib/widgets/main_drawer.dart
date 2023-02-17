import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_education/Service/auth.dart';
import 'package:security_education/Utils/media_query.dart';
import 'package:security_education/screens/master_screen.dart';
import 'package:security_education/screens/test_screen.dart';
import 'package:security_education/widgets/text_widget.dart';
import 'dart:math' as math; // import this

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTitle(
      String title, IconData icon, Color color, Function tabHandler) {
    return ListTile(
        selectedTileColor: Colors.black,
        leading: Icon(
          icon,
          size: 26,
          color: color,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: color, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        onTap: () => tabHandler());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.mediaWidth;
    final screenHeight = context.mediaHeight;
    return Drawer(
      backgroundColor: Colors.blue,
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.13),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topLeft,
              color: Theme.of(context).colorScheme.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextWidget("セキュリティー ", FontWeight.w900, 20, Colors.white,
                      "SourceHan"),
                  TextWidget(
                      "教育 ", FontWeight.w200, 70, Colors.white, "SourceHan"),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            buildListTitle("教育受講", Icons.menu_book, Colors.white, () {
              TextStyle(color: Colors.blue);

              Navigator.of(context)
                  .pushReplacementNamed(MasterScreen.routeName);
            }),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.13),
              child: Container(
                height: 1,
                color: const Color.fromARGB(255, 24, 221, 243),
              ),
            ),
            buildListTitle("テスト", Icons.app_registration_sharp, Colors.black38,
                () {
              TextStyle(color: Colors.green);
              Navigator.of(context).pushReplacementNamed(TestScreen.routeName);
            }),
            const SizedBox(
              height: 100,
            ),
            buildListTitle("退出", Icons.arrow_back, Colors.black38, () {
              Provider.of<Auth>(context,listen: false).logout();
              // Navigator.of(context).pushReplacementNamed(TestScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
