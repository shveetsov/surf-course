import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_13/app_theme.dart';

class SettingsRepository {
  final SharedPreferences preferences;

  static const _isAppThemeScheme = 'app_theme_scheme';
  static const _themeMode = 'themeMode';

  SettingsRepository({required this.preferences});

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await preferences.setString(_themeMode, themeMode.toString());
  }

  Future<ThemeMode> getThemeMode() async {
    String themeModeString = preferences.getString(_themeMode) ?? ThemeMode.system.toString();
    return ThemeMode.values.firstWhere((e) => e.toString() == themeModeString);
  }

  Future<void> setAppThemeScheme(AppThemeScheme appThemeScheme) async {
    await preferences.setString(_isAppThemeScheme, appThemeScheme.toString());
  }

  Future<AppThemeScheme> getAppThemeScheme() async {
    String appThemeSchemeString = preferences.getString(_isAppThemeScheme) ?? 'scheme1';
    return AppThemeScheme.values.firstWhere((e) => e.toString() == appThemeSchemeString);
  }
}
