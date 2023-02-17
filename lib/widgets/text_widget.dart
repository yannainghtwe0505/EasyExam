import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final String fontFamily;
  const TextWidget(this.title, this.fontWeight, this.fontSize, this.color,this.fontFamily,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color,fontFamily: fontFamily),
    );
  }
}
