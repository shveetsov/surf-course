import 'package:flutter/material.dart';

import 'app_constants.dart';

// Не менять значения! Так как они записаны в память
enum AppThemeScheme {
  scheme1('scheme1'),
  scheme2('scheme2'),
  scheme3('scheme3');

  const AppThemeScheme(this.name);
  final String name;

  @override
  String toString() => name;
}

class AppThemeData {
  // 1 схема
  final ThemeData scheme1Light = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.blackAndBrown),
    ),
    primaryColor: AppColors.greenLawn,
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        // Названия полей кнопок в профиле и награды
        customTextColor1: AppColors.motherOfPearlBlackberry,
        // цвет текста внутри кнопки в профиле
        customTextColor2: AppColors.blackAndBrown,
        // Цвет кнопки в профиле
        customTextColor3: AppColors.white1,
        // Цвет фона всплывающего окна
        customTextColor4: AppColors.white,
        // Цвет за фоном фона всплывающего окна
        customTextColor5: AppColors.blackAndBrown.withOpacity(0.6),
        // Цвет фона цветовой схемы
        customTextColor6: AppColors.smokyWhite,
        // Цвет кнопки в всп окне
        customTextColor7: AppColors.persianBlue,
      ),
    ],
  );

  final ThemeData scheme1Dark = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.white),
    ),
    primaryColor: AppColors.greenLawn,
    scaffoldBackgroundColor: AppColors.black ,
    brightness: Brightness.dark,
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        // Названия полей кнопок в профиле и награды
        customTextColor1: AppColors.motherOfPearlBlackberry,
        // цвет текста внутри кнопки в профиле ----
        customTextColor2: AppColors.white,
        // Цвет кнопки в профиле
        customTextColor3: AppColors.blackAndBrown,
        // Цвет фона всплывающего окна
        customTextColor4: AppColors.blackAndBrown,
        // Цвет за фоном фона всплывающего окна
        customTextColor5: AppColors.black.withOpacity(0.8),
        // Цвет фона цветовой схемы
        customTextColor6: AppColors.signalBlack,
        // Цвет кнопки в всп окне
        customTextColor7: AppColors.persianBlue,
      ),
    ],
  );

  // 2 схема
  final ThemeData scheme2Light = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lavender,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.sapphireBlue),
    ),
    primaryColor: AppColors.royalBlue,
    scaffoldBackgroundColor: AppColors.lavender,
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        // Названия полей кнопок в профиле и награды
        customTextColor1: AppColors.blueGray,
        // цвет текста внутри кнопки в профиле
        customTextColor2: AppColors.sapphireBlue,
        // Цвет кнопки в профиле
        customTextColor3: AppColors.white,
        // Цвет фона всплывающего окна
        customTextColor4: AppColors.white,
        // Цвет за фоном фона всплывающего окна
        customTextColor5: AppColors.sapphireBlue.withOpacity(0.6),
        // Цвет фона цветовой схемы
        customTextColor6: AppColors.lavender,
        // Цвет кнопки в всп окне
        customTextColor7: AppColors.royalBlue,
      ),
    ],
  );

  final ThemeData scheme2Dark = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.sapphireBlue,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.white),
    ),
    primaryColor: AppColors.royalBlue,
    scaffoldBackgroundColor: AppColors.sapphireBlue ,
    brightness: Brightness.dark,
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        customTextColor1: AppColors.blueGray,
        customTextColor2: AppColors.white,
        customTextColor3: AppColors.moderatePurplishBlue,
        customTextColor4: AppColors.moderatePurplishBlue,
        customTextColor5: AppColors.sapphireBlue.withOpacity(0.8),
        customTextColor6: AppColors.marengo,
        customTextColor7: AppColors.royalBlue,
      ),
    ],
  );

  // 3 схема
  final ThemeData scheme3Light = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.linen,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.blackAndBrown),
    ),
    primaryColor: AppColors.darkAmber,
    scaffoldBackgroundColor: AppColors.linen,
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        customTextColor1: AppColors.paleGreyBrown,
        customTextColor2: AppColors.blackAndBrown,
        customTextColor3: AppColors.white,
        customTextColor4: AppColors.white,
        customTextColor5: AppColors.greyUmber.withOpacity(0.6),
        customTextColor6: AppColors.smokyWhite1,
        customTextColor7: AppColors.darkAmber,
      ),
    ],
  );

  final ThemeData scheme3Dark = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackAndBrown1,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.white),
    ),
    primaryColor: AppColors.darkAmber,
    scaffoldBackgroundColor: AppColors.blackAndBrown1 ,
    brightness: Brightness.dark,
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        customTextColor1: AppColors.paleGreyBrown,
        customTextColor2: AppColors.white,
        customTextColor3: AppColors.greyUmber,
        customTextColor4: AppColors.greyUmber,
        customTextColor5: AppColors.greenishBlack.withOpacity(0.8),
        customTextColor6: AppColors.darkGrey,
        customTextColor7: AppColors.darkAmber,
      ),
    ],
  );

  ThemeData getThemeData(AppThemeScheme scheme, Brightness brightness) {
    switch (scheme) {
      case AppThemeScheme.scheme1:
        return brightness == Brightness.light ? scheme1Light : scheme1Dark;
      case AppThemeScheme.scheme2:
        return brightness == Brightness.light ? scheme2Light : scheme2Dark;
      case AppThemeScheme.scheme3:
        return brightness == Brightness.light ? scheme3Light : scheme3Dark;
      default:
        return ThemeData(brightness: brightness);
    }
  }

}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color? customTextColor1;
  final Color? customTextColor2;
  final Color? customTextColor3;
  final Color? customTextColor4;
  final Color? customTextColor5;
  final Color? customTextColor6;
  final Color? customTextColor7;

  CustomThemeExtension({this.customTextColor1, this.customTextColor2, this.customTextColor3, this.customTextColor4, this.customTextColor5, this.customTextColor6, this.customTextColor7,});

  @override
  CustomThemeExtension copyWith({Color? customTextColor1, Color? customTextColor2, Color? customTextColor3, Color? customTextColor4, Color? customTextColor5, Color? customTextColor6, Color? customTextColor7}) {
    return CustomThemeExtension(
      customTextColor1: customTextColor1 ?? this.customTextColor1,
      customTextColor2: customTextColor2 ?? this.customTextColor2,
      customTextColor3: customTextColor3 ?? this.customTextColor3,
      customTextColor4: customTextColor4 ?? this.customTextColor4,
      customTextColor5: customTextColor5 ?? this.customTextColor5,
      customTextColor6: customTextColor6 ?? this.customTextColor6,
      customTextColor7: customTextColor7 ?? this.customTextColor7,
    );
  }

  @override
  CustomThemeExtension lerp(ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      customTextColor1: Color.lerp(customTextColor1, other.customTextColor1, t),
      customTextColor2: Color.lerp(customTextColor2, other.customTextColor2, t),
      customTextColor3: Color.lerp(customTextColor3, other.customTextColor3, t),
      customTextColor4: Color.lerp(customTextColor4, other.customTextColor4, t),
      customTextColor5: Color.lerp(customTextColor5, other.customTextColor5, t),
      customTextColor6: Color.lerp(customTextColor6, other.customTextColor6, t),
      customTextColor7: Color.lerp(customTextColor7, other.customTextColor7, t),
    );
  }
}

