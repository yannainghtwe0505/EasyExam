import 'package:flutter/material.dart';
import 'package:security_education/Utils/DummyTable.dart';
import 'package:security_education/screens/confirm_screen.dart';
import 'package:security_education/screens/test_screen.dart';
import 'package:security_education/widgets/footer_copyright_widget.dart';

import '../widgets/text_widget.dart';
import '../Utils/media_query.dart';

Color greyLight = Color(0xff959595);

enum SingingCharacter { ans1, ans2, ans3, ans4 }

class TestDetailScreen extends StatefulWidget {
  static const String routeName = "test-detail";
  const TestDetailScreen({super.key});

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  bool isPressed = false;

  Widget radioAnswersWidget(String text, SingingCharacter ansIndex,
      SingingCharacter? character, int thisIndex) {
    var selected = _character.toString().contains((thisIndex + 1).toString());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffE8E8E8),
          width: selected ? 0 : 1.5,
        ),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            blurRadius: .1,
            color: selected ? Colors.blue : Colors.white,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
              color: _character.toString().contains((thisIndex + 1).toString())
                  ? Colors.white
                  : greyLight,
              fontSize: 14,
              fontFamily: "NotoSansJp"),
        ),
        leading: Theme(
          data: ThemeData(unselectedWidgetColor: greyLight),
          child: Radio<SingingCharacter>(
            value: ansIndex,
            activeColor: Colors.white,
            groupValue: character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                isPressed = true;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buttonWidget(double screenWidth, double screenHeight, String label,
      Function() onPressed) {
    var wrongCondition = (label == "次へ" || label == "完了") &&
        _character.toString() != TestDetailData[0][questionIndex][5].toString();
    var rightCondition = (label == "次へ" || label == "完了") &&
        _character.toString() == TestDetailData[0][questionIndex][5].toString();

    var makeAns = (label == "答え合わせ");
    return SizedBox(
      width: screenWidth * 0.35,
      height: screenHeight * 0.06,
      child: OutlinedButton(
        onPressed: wrongCondition ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: wrongCondition || makeAns || rightCondition
              ? null
              : BorderSide(width: 1, color: greyLight),
          backgroundColor: wrongCondition
              ? const Color(0xffE8E8E8)
              : makeAns || rightCondition
                  ? const Color(0xff00A0E8)
                  : null,
        ),
        child: Text(
          label,
          style: TextStyle(
              color: makeAns || rightCondition ? Colors.white : greyLight,
              fontSize: 14,
              fontFamily: "NotoSansJp"),
        ),
      ),
    );
  }

  SingingCharacter? _character = SingingCharacter.ans1;
  var questionIndex = 0;
  double sliderValue = 0;
  int pageTypeIndex = 0;
  bool correct = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.mediaWidth;
    final screenHeight = context.mediaHeight;

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
            'テスト実施', FontWeight.bold, 16, Color(0xff454545), "NotoSansJP"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            SliderTheme(
              data: SliderThemeData(
                  // here
                  trackShape: CustomTrackShape(),
                  thumbShape: SliderComponentShape.noThumb,
                  overlayShape: SliderComponentShape.noOverlay),
              child: Slider(
                value: sliderValue,
                min: 0,
                max: TestDetailData[0].length - 1.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    // sliderValue = value;
                    // questionIndex = sliderValue.round();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.04, horizontal: 30),
                    child: pageTypeIndex == 0
                        ? Column(
                            children: [
                              TextWidget(
                                  "問題${questionIndex + 1}",
                                  FontWeight.bold,
                                  18,
                                  Colors.black,
                                  "NotoSansJP"),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              TextWidget(
                                  TestDetailData[0][questionIndex][0],
                                  FontWeight.normal,
                                  16,
                                  Color(0xff676767),
                                  "NotoSansJP"),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              radioAnswersWidget(
                                  TestDetailData[0][questionIndex][1],
                                  SingingCharacter.ans1,
                                  _character,
                                  0),
                              radioAnswersWidget(
                                  TestDetailData[0][questionIndex][2],
                                  SingingCharacter.ans2,
                                  _character,
                                  1),
                              radioAnswersWidget(
                                  TestDetailData[0][questionIndex][3],
                                  SingingCharacter.ans3,
                                  _character,
                                  2),
                              radioAnswersWidget(
                                  TestDetailData[0][questionIndex][4],
                                  SingingCharacter.ans4,
                                  _character,
                                  3),
                              SizedBox(
                                height: screenHeight * 0.04,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  buttonWidget(
                                    screenWidth,
                                    screenHeight,
                                    "戻る",
                                    () {
                                      setState(() {
                                        if (questionIndex > 0) {
                                          questionIndex--;
                                          sliderValue--;
                                        }
                                      });
                                    },
                                  ),
                                  buttonWidget(
                                    screenWidth,
                                    screenHeight,
                                    "答え合わせ",
                                    () {
                                      setState(() {
                                        pageTypeIndex = 1;
                                        if (_character.toString() ==
                                            TestDetailData[0][questionIndex][5]
                                                .toString()) {
                                          correct = true;
                                        } else {
                                          correct = false;
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : ConfirmScreen(
                            correct ? 0 : 1,
                            TestDetailData[0][questionIndex][1],
                            TestDetailData[0][questionIndex][2],
                            TestDetailData[0][questionIndex][3],
                            TestDetailData[0][questionIndex][4],
                            TestDetailData[0][questionIndex][5].toString(),
                            TestDetailData[0][questionIndex][6],
                            buttonWidget(
                              screenWidth,
                              screenHeight,
                              "やり直す",
                              () {
                                setState(() {
                                  pageTypeIndex = 0;
                                });
                              },
                            ),
                            buttonWidget(
                              screenWidth,
                              screenHeight,
                              questionIndex < TestDetailData[0].length - 1
                                  ? "次へ"
                                  : "完了",
                              () {
                                setState(() {
                                  if (_character.toString() ==
                                      TestDetailData[0][questionIndex][5]
                                          .toString()) {
                                    if (questionIndex <
                                        TestDetailData[0].length - 1) {
                                      pageTypeIndex = 0;
                                      questionIndex++;
                                      sliderValue++;
                                    } else {
                                      Navigator.of(context)
                                          .pushNamed(TestScreen.routeName);
                                    }
                                  } else {}
                                });
                              },
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight! - 0.2;
    final trackLeft = offset.dx;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, 0, trackWidth, trackHeight!);
  }
}
