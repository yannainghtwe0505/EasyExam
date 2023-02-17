import 'package:flutter/material.dart';
import 'package:security_education/Utils/DummyTable.dart';
import 'package:security_education/models/test.dart';
import 'package:security_education/widgets/drawer_item_body_widget.dart';
import '../widgets/drawer_item_main_widget.dart';

class MasterScreen extends StatefulWidget {
  static const routeName = "master_page";
  const MasterScreen({super.key});
  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 0;
  final List<Test> _notStartYet = [];
  final List<Test> _testing = [];
  final List<Test> _finish = [];

  @override
  void initState() {
    _pages = [
      {"page": DrawerItemBodyWidget(dummyData, 0), "title": "p1"},
      {"page": DrawerItemBodyWidget(_notStartYet, 0), "title": "p2"},
      {"page": DrawerItemBodyWidget(_testing, 0), "title": "p3"},
      {"page": DrawerItemBodyWidget(_finish, 0), "title": "p4"},
    ];
    _notStartYet.addAll(dummyData.where((test) => test.status == 1));
    _testing.addAll(dummyData.where((test) => test.status == 2));
    _finish.addAll(dummyData.where((test) => test.status == 3));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DrawerItemHomeWidget(
        "教育受講一覧", _selectedPageIndex, _pages, _selectPage, 0);
  }
}
