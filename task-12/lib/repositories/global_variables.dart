import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class GlobalTextStyle {
  static TextStyle titleApp = GoogleFonts.ubuntu(
      textStyle: const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.13,
  ));
  static TextStyle titleColoredCard = GoogleFonts.ubuntu(
      textStyle: const TextStyle(
        fontSize: 12,
        height: 1.33,
      ));
  static TextStyle textColoredCard = GoogleFonts.ubuntu(
      textStyle: const TextStyle(
        fontSize: 16,
        height: 1.5,
      ));
}

abstract class GlobalColors {
  static const sapphireBlue = Color(0xFF252838);
}