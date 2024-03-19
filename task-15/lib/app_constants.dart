import 'package:flutter/material.dart';

abstract class AppTexts {
  static const clickOnTheBall = 'Нажмите на шар или\nпотрясите телефон';
}

abstract class AppTextStyles {
  static TextStyle clickOnTheBall = const TextStyle(fontSize: 16, color: AppColors.dullGrey);
  static TextStyle textMagicBall = const TextStyle(fontSize: 56, color: AppColors.white);
}

abstract class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const dullGrey = Color(0xFF727272);
  static const deepPurpleBlue = Color(0xFF100C2C);
  static const darkBlue = Color(0xFF000002);
}

abstract class AppAssets {
  static const bg = 'assets/images/image.jpg';
}