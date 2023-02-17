import 'package:flutter/material.dart';
import 'package:security_education/widgets/text_widget.dart';
import '../Utils/media_query.dart';

class ConfirmScreen extends StatelessWidget {
  final int conditionStatus;
  final String ans1;
  final String ans2;
  final String ans3;
  final String ans4;
  final String explain;
  final String rightAns;
  final Widget reviewBtn;
  final Widget nextBtn;
  ConfirmScreen(this.conditionStatus, this.ans1, this.ans2, this.ans3,
      this.ans4, this.rightAns, this.explain, this.reviewBtn, this.nextBtn,
      {super.key});

  List<Map<String, Object>> rightAndWrongAnswer = [
    {"title": "回答正解", "color": Colors.green, "icon": Icon(Icons.check)},
    {"title": "回答錯誤", "color": Colors.red, "icon": Icon(Icons.close)}
  ];
  Widget answer(double screenHeight, ans, String ansIndex) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: TextWidget(
          ans,
          FontWeight.normal,
          14,
          rightAns.contains(ansIndex)
              ? rightAndWrongAnswer[conditionStatus]["color"] as Color
              : const Color(0xff959595),
          "NotoSansJP"),
    );
  }

  Widget title(double screenHeight, text) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.05, bottom: screenHeight * 0.01),
      child: TextWidget(
          text, FontWeight.bold, 18, const Color(0xff454545), "NotoSansJP"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.mediaHeight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: screenHeight * 0.05,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  rightAndWrongAnswer[conditionStatus]["color"] as Color,
            ),
            onPressed: () {
              print(rightAns);
            },
            icon: rightAndWrongAnswer[conditionStatus]["icon"] as Icon,

            label: Text(rightAndWrongAnswer[conditionStatus]["title"]
                as String), // <-- Text
          ),
        ),
        title(screenHeight, "解説"),
        answer(screenHeight, explain, "This"),
        title(screenHeight, "あなたの解答"),
        rightAns.contains("ans1")
            ? answer(screenHeight, ans1, "ans1")
            : rightAns.contains("ans2")
                ? answer(screenHeight, ans2, "ans2")
                : rightAns.contains("ans3")
                    ? answer(screenHeight, ans3, "ans3")
                    : answer(screenHeight, ans4, "ans4"),
        SizedBox(
          height: screenHeight * 0.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [reviewBtn, nextBtn],
        ),
      ],
    );
  }
}
