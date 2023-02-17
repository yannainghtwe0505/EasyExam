import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int _selectedPageIndex;
  final Function(int)? onTap;
  final int pageStatus;

  const BottomNavigationBarWidget(
      this._selectedPageIndex, this.onTap, this.pageStatus,
      {super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  var navbarItemText = [
    ["すべて", "未着手", "受講中", "受講完了"],
    ["すべて", "未回答", "回答中", "回答完了"]
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 1,
            spreadRadius: 2,
          ), //BoxShadow
        ],
      ),
      child: BottomNavigationBar(
        items: [
          _bnbItem(navbarItemText[widget.pageStatus][0]),
          _bnbItem(navbarItemText[widget.pageStatus][1]),
          _bnbItem(navbarItemText[widget.pageStatus][2]),
          _bnbItem(navbarItemText[widget.pageStatus][3]),
        ],
        elevation: 100,
        onTap: widget.onTap,
        unselectedItemColor: Colors.green,
        selectedItemColor: Colors.blue,
        currentIndex: widget._selectedPageIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "NotoSansJp",
          fontSize: 16,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

BottomNavigationBarItem _bnbItem(String text) {
  return BottomNavigationBarItem(
    backgroundColor: Colors.grey,
    icon: const Icon(
      Icons.all_inclusive_sharp,
      size: 0,
      color: Colors.white,
    ),
    label: text,
  );
}
