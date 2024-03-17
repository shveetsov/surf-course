import 'package:flutter/material.dart';

abstract class AppAssets {
  static const logo = 'assets/images/logo.jpg';
}

abstract class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF222222);
  static const gray = Color(0xFFBFBFBF);
}

abstract class AppTextStyles {
  static TextStyle counterPhoto =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, height: 2);
}
