import 'package:flutter/material.dart';
import 'package:security_education/Utils/DummyTable.dart';
import 'package:security_education/models/test.dart';
import 'package:security_education/widgets/drawer_item_body_widget.dart';
import '../widgets/drawer_item_main_widget.dart';

class TestScreen extends StatefulWidget {
  static const routeName = "test_page";
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 0;
  final List<Test> _notStartYet = [];
  final List<Test> _testing = [];
  final List<Test> _finish = [];

  @override
  void initState() {
    _pages = [
      {"page": DrawerItemBodyWidget(testData, 1), "title": "p1"},
      {"page": DrawerItemBodyWidget(_notStartYet, 1), "title": "p2"},
      {"page": DrawerItemBodyWidget(_testing, 1), "title": "p3"},
      {"page": DrawerItemBodyWidget(_finish, 1), "title": "p4"},
    ];
    _notStartYet.addAll(testData.where((test) => test.status == 1));
    _testing.addAll(testData.where((test) => test.status == 2));
    _finish.addAll(testData.where((test) => test.status == 3));
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DrawerItemHomeWidget(
        "テスト一覧", _selectedPageIndex, _pages, _selectPage, 1);
  }
}
