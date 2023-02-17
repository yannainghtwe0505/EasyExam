import 'package:flutter/material.dart';
import 'package:security_education/screens/test_api_screen.dart';
import 'package:security_education/widgets/text_widget.dart';
import 'bottom_navigation_bar_widget.dart';
import 'main_drawer.dart';

class DrawerItemHomeWidget extends StatelessWidget {
  final String title;
  final int selectedPageIndex;
  final List<Map<String, Object>>? pages;
  final Function(int)? onTap;
  final int pageStatus; //0 for master and 1 for testPage

  const DrawerItemHomeWidget(this.title, this.selectedPageIndex, this.pages,
      this.onTap, this.pageStatus,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextWidget(title, FontWeight.w700, 16, const Color(0xff222222),
              "NotoSansJP"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          actions: [
            Container(
                width: 35,
                margin: const EdgeInsets.only(top: 10, bottom: 10, right: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(TestAPI.routeName);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Image.asset(
                      'assets/images/acc.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ],
        ),
        drawer: const MainDrawer(),
        body: pages![selectedPageIndex]["page"] as Widget,
        bottomNavigationBar:
            BottomNavigationBarWidget(selectedPageIndex, onTap, pageStatus));
  }
}
