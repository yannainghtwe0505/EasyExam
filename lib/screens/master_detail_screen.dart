import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:security_education/widgets/text_widget.dart';

class MasterDetailScreen extends StatelessWidget {
  static String routeName = "MasterDetail";
  final String url;
  const MasterDetailScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('6月分セキュリティ教育', FontWeight.bold, 16,
            Color(0xff454545), "NotoSansJP"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const PDF(
        swipeHorizontal: true,
        fitEachPage: true,
      ).cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
