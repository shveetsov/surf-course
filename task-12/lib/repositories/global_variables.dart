import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyle {
  static TextStyle titleApp = GoogleFonts.ubuntu(
      textStyle: const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.13,
        color: AppColors.sapphireBlue
  ));
  static TextStyle titleColoredCard = GoogleFonts.ubuntu(
      textStyle: const TextStyle(
        fontSize: 12,
        height: 1.33,
        color: AppColors.sapphireBlue
      ));
  static TextStyle textColoredCard = GoogleFonts.ubuntu(
      textStyle: const TextStyle(
        fontSize: 16,
        height: 1.5,
        color: AppColors.sapphireBlue
      ));
}

abstract class AppColors {
  static const sapphireBlue = Color(0xFF252838);
  static const white = Color(0xFFFFFFFF);
}

class AppAssets {
  static const assetsIconCopy = 'assets/icons/copy_icon.svg';
}