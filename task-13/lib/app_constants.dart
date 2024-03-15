import 'package:flutter/material.dart';

abstract class AppTexts {
  static const appBarTitle = 'Профиль';
  static const appBarSave = 'Save';
  static const editAvatar = 'Edit';
  static const myAwards = 'Мои награды';
  static const name = 'Имя';
  static const email = 'Email';
  static const dateOfBirth = 'Дата рождения';
  static const team = 'Команда';
  static const position = 'Позиция';
  static const designTheme = 'Тема оформления';
  static const themeSystem = 'Системная';
  static const themeLight = 'Светлая';
  static const themeDark = 'Темная';
  static const done = 'Готово';
  static const themeScheme = 'Схема';
  static const logOut = 'Log out';
}

abstract class AppAssets {
  static const iconBack = 'assets/icons/back_icon.svg';
  static const avatar = 'assets/images/avatar.jpg';
  static const iconNextButton = 'assets/icons/chevron-right.svg';
  static const iconScheme1 = 'assets/icons/scheme1.svg';
  static const iconScheme2 = 'assets/icons/scheme2.svg';
  static const iconScheme3 = 'assets/icons/scheme3.svg';
}

abstract class AppTextStyles {
  static TextStyle appBarTitle =
      const TextStyle(fontSize: 18, height: 1.78, fontWeight: FontWeight.w700);
  static TextStyle appBarSave = const TextStyle(fontSize: 14, height: 1.14);
  static TextStyle avatarEdit = const TextStyle(fontSize: 12, height: 1.33);
  static TextStyle myAwardsIcons = const TextStyle(fontSize: 32);
  static TextStyle myAwardsTitle = const TextStyle(fontSize: 14, height: 1.43);
  static TextStyle logOut = const TextStyle(fontSize: 16, height: 1.5);
  static TextStyle showWindow = const TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w700);
}

abstract class AppColors {
  static const black = Color(0xFF000000);
  static const blackAndBrown = Color(0xFF222222);
  static const white = Color(0xFFFFFFFF);
  static const white1 = Color(0xFFFAFAFA);
  static const gainsborough = Color(0xFFDDDDDD);
  static const smokyWhite = Color(0xFFF6F6F6);
  static const smokyWhite1 = Color(0xFFFAF8F7);
  static const signalBlack = Color(0xFF292929);
  static const motherOfPearlBlackberry = Color(0xFF77767B);
  static const persianBlue = Color(0xFF5114FF);
  static const greenLawn = Color(0xFF6DD902);
  static const blueGray = Color(0xFF7B8EBE);
  static const royalBlue = Color(0xFF5261EB);
  static const paleGreyBrown = Color(0xFFBE937B);
  static const linen = Color(0xFFFCF8F4);
  static const darkAmber = Color(0xFFFF7A00);
  static const orangeRedCrayola = Color(0xFFFF392A);
  static const lavender = Color(0xFFF4F7FC);
  static const sapphireBlue = Color(0xFF242439);
  static const moderatePurplishBlue = Color(0xFF384057);
  static const marengo = Color(0xFF444C65);
  static const greyUmber = Color(0xFF3C322F);
  static const blackAndBrown1 = Color(0xFF262020);
  static const darkGrey = Color(0xFF4A3F3B);
  static const greenishBlack = Color(0xFF201B1A);
}
