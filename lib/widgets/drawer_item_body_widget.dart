import 'package:flutter/material.dart';
import 'package:security_education/widgets/test_item_widget.dart';

import '../models/test.dart';

class DrawerItemBodyWidget extends StatelessWidget {
  final List<Test> items;
  final int pageStatus;
  const DrawerItemBodyWidget(this.items, this.pageStatus, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return TestItem(
            imageUrl: items[index].imageUrl,
            title: items[index].title,
            status: items[index].status,
            pageStatus: pageStatus,
          );
        },
        itemCount: items.length);
  }
}
