import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class GlobalColors {
  static const brightGreen = Color(0xFF67cd00);
  static const nightBlue = Color(0xFF252849);
  static const motherOfPearlBlackberry = Color(0xFF60607B);
  static const smokyWhite = Color(0xFFF1F1F1);
  static const lightGrey = Color(0xFFB5B5B5);
  static const red = Color(0xFFFF0000);
}

abstract class GlobalStyleText {
  static TextStyle title = GoogleFonts.sora(
      textStyle: const TextStyle(
          color: GlobalColors.nightBlue,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.33));
  static TextStyle appBarDate = GoogleFonts.sora(
      textStyle: const TextStyle(
          color: GlobalColors.nightBlue,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 1.6));
  static TextStyle textProduct = GoogleFonts.sora(
      textStyle: const TextStyle(
          color: GlobalColors.nightBlue,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.3));
  static TextStyle textBoldProduct = GoogleFonts.sora(
      textStyle: const TextStyle(
          color: GlobalColors.nightBlue,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.3));
  static TextStyle total = GoogleFonts.sora(
      textStyle: const TextStyle(
          color: GlobalColors.nightBlue,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1.5));
  static TextStyle sort = GoogleFonts.sora(
      textStyle: const TextStyle(
          color: GlobalColors.nightBlue,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.2));
  static TextStyle navBar = GoogleFonts.sora(
      textStyle: const TextStyle(
          color: GlobalColors.nightBlue,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          height: 1.26));

}
