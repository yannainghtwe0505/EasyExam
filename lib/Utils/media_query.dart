import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
   double get mediaWidth => MediaQuery.of(this).size.width;
   double get mediaHeight => MediaQuery.of(this).size.height;
}
