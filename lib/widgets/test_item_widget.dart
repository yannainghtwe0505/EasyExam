import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:security_education/Utils/media_query.dart';
import 'package:security_education/screens/master_detail_screen.dart';
import 'package:security_education/screens/test_detail_screen.dart';

class TestItem extends StatelessWidget {
  final String imageUrl, title;
  final int status;
  final int pageStatus;
  const TestItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.status,
      required this.pageStatus});
// width 1=img(0.23)+mainPadding(0.05)+sizeBox(0.05)+flexible()
// vertical has no problem as we use listView
  void detailPdf(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => const MasterDetailScreen(
            url: 'http://africau.edu/images/default/sample.pdf',
          ),
        ));
  }

  void testPage(BuildContext context) {
    Navigator.of(context).pushNamed(TestDetailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    List testStatus = [
      ["未着手", "受講中", "受講完了"],
      ["未回答", "回答中", "回答完了"]
    ];
    List colorStatus = const [
      Color(0xFFDD4D4D),
      Color(0xFF00A0E8),
      Color(0xFF4CB796)
    ];
    final screenWidth = context.mediaWidth;
    return Padding(
      padding: EdgeInsets.only(
          top: 22, left: screenWidth * 0.05, right: screenWidth * 0.05),
      child: InkWell(
        onTap: () => pageStatus == 0 ? detailPdf(context) : testPage(context),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    imageUrl,
                    height: screenWidth * 0.23,
                    width: screenWidth * 0.23,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: screenWidth * 0.23),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "NotoSansJp",
                                  fontSize: 14,
                                  color: Color(0xFF2F2F2F)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: screenWidth * 0.15, //　2 of 3 of image
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          backgroundColor:
                                              colorStatus[status - 1]),
                                      onPressed: () {},
                                      child: Text(
                                        testStatus[pageStatus][status - 1],
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      )),
                                ),
                              ],
                            )
                          ]),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Container(
                height: 1,
                color: Colors.black12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
