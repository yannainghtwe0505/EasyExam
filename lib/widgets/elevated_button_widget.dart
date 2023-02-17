import 'dart:ui';

import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String title;
  final Color borderColor, bgColor, textColor;
  const ElevatedButtonWidget(
      this.title, this.borderColor, this.bgColor, this.textColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    const status = 1;
    return InkWell(
      borderRadius: BorderRadius.circular(600),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(
              width: 1.5,
              color: borderColor,
            ),
            backgroundColor: status == 0 ? bgColor : Colors.white,
          ),
          child: FittedBox(
            child: Text(
              title,
              style: TextStyle(
                  color: status == 0 ? textColor : Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
