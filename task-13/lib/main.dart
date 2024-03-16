import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_13/app_constants.dart';
import 'package:task_13/repositories/settings_repository.dart';

import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final SettingsRepository settingsRepository =
      SettingsRepository(preferences: preferences);

  runApp(MyApp(
    settingsRepository: settingsRepository,
  ));
}

class MyApp extends StatefulWidget {
  final SettingsRepository settingsRepository;

  const MyApp({super.key, required this.settingsRepository});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  AppThemeScheme appThemeScheme = AppThemeScheme.scheme1;

  @override
  void initState() {
    super.initState();
    loadThemeMode();
  }

  Future<void> loadThemeMode() async {
    themeMode = await widget.settingsRepository.getThemeMode();
    appThemeScheme = await widget.settingsRepository.getAppThemeScheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData().getThemeData(appThemeScheme, Brightness.light),
      darkTheme: AppThemeData().getThemeData(appThemeScheme, Brightness.dark),
      themeMode: themeMode,
      home: MainScreen(
        settingsRepository: widget.settingsRepository,
        loadThemeMode: loadThemeMode(),
        themeMode: themeMode,
        appThemeScheme: appThemeScheme,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final SettingsRepository settingsRepository;
  final Future<void> loadThemeMode;
  final ThemeMode themeMode;
  final AppThemeScheme appThemeScheme;

  const MainScreen({
    super.key,
    required this.settingsRepository,
    required this.loadThemeMode,
    required this.themeMode,
    required this.appThemeScheme,
  });



  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final customTheme = Theme.of(context).extension<CustomThemeExtension>();

    void showWindow() {
      showModalBottomSheet(
        context: context,
        backgroundColor: customTheme!
            .customTextColor4!,
        barrierColor: customTheme
            .customTextColor5!,
        elevation: 0,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => SortWindow(
          loadThemeMode: loadThemeMode,
          settingsRepository: settingsRepository,
          themeMode: themeMode,
          appThemeScheme: appThemeScheme,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppTexts.appBarTitle,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppAssets.iconBack,
            colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                AppTexts.appBarSave,
                style: AppTextStyles.appBarSave
                    .copyWith(color: theme.primaryColor),
              ))
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 24, left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Avatar(
                      avatarAssets: AppAssets.avatar,
                    ),
                    const SizedBox(height: 24),
                    MyAwards(
                      listAwards: const ['🥇', '🥇', '🥉', '🥈', '🥉'],
                      color: customTheme!.customTextColor1!,
                    ),
                    const SizedBox(height: 24),
                    ButtonProfile(
                      title: AppTexts.name,
                      text: 'Маркус Хассельборг',
                      icon: false,
                      onTap: () {},
                      context: context,
                    ),
                    const SizedBox(height: 8),
                    ButtonProfile(
                      title: AppTexts.email,
                      text: 'MarkusHSS@gmail.com',
                      icon: false,
                      onTap: () {},
                      context: context,
                    ),
                    const SizedBox(height: 8),
                    ButtonProfile(
                      title: AppTexts.dateOfBirth,
                      text: '03.03.1986',
                      icon: false,
                      onTap: () {},
                      context: context,
                    ),
                    const SizedBox(height: 8),
                    ButtonProfile(
                      title: AppTexts.team,
                      text: 'Сборная Швеции',
                      icon: true,
                      onTap: () {},
                      context: context,
                    ),
                    const SizedBox(height: 8),
                    ButtonProfile(
                      title: AppTexts.position,
                      text: 'Скип',
                      icon: true,
                      onTap: () {},
                      context: context,
                    ),
                    const SizedBox(height: 8),
                    ButtonProfile(
                      title: AppTexts.designTheme,
                      text: themeMode == ThemeMode.system ? AppTexts.themeSystem :themeMode == ThemeMode.light ? AppTexts.themeLight : AppTexts.themeDark,
                      icon: true,
                      onTap: showWindow,
                      context: context,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const ButtonLogOut(),
            ],
          ),
        ),
      ),
    );
  }
}

class SortWindow extends StatefulWidget {
  final SettingsRepository settingsRepository;
  final Future<void> loadThemeMode;
  ThemeMode themeMode;
  AppThemeScheme appThemeScheme;

  SortWindow({
    super.key,
    required this.settingsRepository,
    required this.loadThemeMode,
    required this.themeMode,
    required this.appThemeScheme,
  });

  @override
  State<SortWindow> createState() => _SortWindowState();
}

class _SortWindowState extends State<SortWindow> {
  ThemeMode _selectedThemeMode = ThemeMode.system;
  AppThemeScheme _selectedAppThemeScheme = AppThemeScheme.scheme2;

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = widget.themeMode;
    _selectedAppThemeScheme = widget.appThemeScheme;
  }

  void _updateDataThemeMode(ThemeMode themeMode) {
    setState(() {
      _selectedThemeMode = themeMode;
    });
  }

  void _updateDataAppThemeScheme(AppThemeScheme appThemeScheme) {
    setState(() {
      _selectedAppThemeScheme = appThemeScheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final customTheme =
        Theme.of(context).extension<CustomThemeExtension>();
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 4,
                  width: 24,
                  decoration: BoxDecoration(
                    color: const Color(0x2EB5B5B5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.designTheme,
                      style: AppTextStyles.showWindow
                          .copyWith(color: customTheme!.customTextColor2!),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: theme.primaryColor,
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RadioListTileTheme(
                themeMode: ThemeMode.system,
                selectedThemeMode: _selectedThemeMode,
                callback: _updateDataThemeMode,
                title: AppTexts.themeSystem,
              ),
              RadioListTileTheme(
                themeMode: ThemeMode.light,
                selectedThemeMode: _selectedThemeMode,
                callback: _updateDataThemeMode,
                title: AppTexts.themeLight,
              ),
              if (_selectedThemeMode == ThemeMode.light)
              ListSchemeTheme(callback: _updateDataAppThemeScheme, selectedAppThemeScheme: _selectedAppThemeScheme,),
              RadioListTileTheme(
                themeMode: ThemeMode.dark,
                selectedThemeMode: _selectedThemeMode,
                callback: _updateDataThemeMode,
                title: AppTexts.themeDark,
              ),
              if (_selectedThemeMode == ThemeMode.dark)
                ListSchemeTheme(callback: _updateDataAppThemeScheme, selectedAppThemeScheme: _selectedAppThemeScheme,),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_selectedThemeMode == ThemeMode.system) {
                        _selectedAppThemeScheme = AppThemeScheme.scheme1;
                      }

                      widget.settingsRepository.setThemeMode(_selectedThemeMode);
                      widget.settingsRepository.setAppThemeScheme(_selectedAppThemeScheme);
                      Navigator.pop(context);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        customTheme.customTextColor7!), // Цвет фона
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Цвет текста
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Скругление углов
                    )),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14), // Отступы внутри кнопки
                    ),
                  ),
                  child: Text(
                    'Готово',
                    style: AppTextStyles.logOut,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListSchemeTheme extends StatefulWidget {
  final Function(AppThemeScheme) callback;
  final AppThemeScheme selectedAppThemeScheme;
  const ListSchemeTheme({super.key, required this.callback, required this.selectedAppThemeScheme});

  @override
  State<ListSchemeTheme> createState() => _ListSchemeThemeState();
}

class _ListSchemeThemeState extends State<ListSchemeTheme> {
  @override
  Widget build(BuildContext context) {
    final customTheme =
    Theme.of(context).extension<CustomThemeExtension>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Цветовая схема', style: AppTextStyles.myAwardsTitle.copyWith(color: customTheme!.customTextColor1!),),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: SchemeTheme(icon: AppAssets.iconScheme1, appThemeScheme: AppThemeScheme.scheme1, selectedAppThemeScheme: widget.selectedAppThemeScheme, callback: widget.callback, title: 'Схема 1',),),
              const SizedBox(width: 16),
              Expanded(child: SchemeTheme(icon: AppAssets.iconScheme2, appThemeScheme: AppThemeScheme.scheme2, selectedAppThemeScheme: widget.selectedAppThemeScheme, callback: widget.callback, title: 'Схема 2',),),
              const SizedBox(width: 16),
              Expanded(child: SchemeTheme(icon: AppAssets.iconScheme3, appThemeScheme: AppThemeScheme.scheme3, selectedAppThemeScheme: widget.selectedAppThemeScheme, callback: widget.callback, title: 'Схема 3',),),
            ],
          ),
        ],
      ),
    );
  }
}



class SchemeTheme extends StatelessWidget {
  final String title;
  final AppThemeScheme appThemeScheme;
  final AppThemeScheme selectedAppThemeScheme;
  final String icon;
  final Function(AppThemeScheme) callback;
  const SchemeTheme({super.key, required this.icon, required this.appThemeScheme, required this.selectedAppThemeScheme, required this.callback, required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final customTheme =
    Theme.of(context).extension<CustomThemeExtension>();
    return GestureDetector(
      onTap: (){
        callback(appThemeScheme);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
          color: customTheme!.customTextColor6!,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selectedAppThemeScheme==appThemeScheme ? theme.primaryColor : Colors.black.withOpacity(0),
          )
        ),
        child: Column(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(height: 4),
            Text(title, style: AppTextStyles.avatarEdit.copyWith(color: selectedAppThemeScheme==appThemeScheme ? customTheme.customTextColor2! : customTheme.customTextColor1!),),
          ],
        ),
      ),
    );
  }
}

class RadioListTileTheme extends StatelessWidget {
  final String title;
  final ThemeMode themeMode;
  final ThemeMode selectedThemeMode;
  final Function(ThemeMode) callback;

  const RadioListTileTheme(
      {super.key,
      required this.themeMode,
      required this.selectedThemeMode,
      required this.callback,
      required this.title,
      });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final customTheme =
    Theme.of(context).extension<CustomThemeExtension>();
    
    return RadioListTile<ThemeMode>(
      title: Text(title, style: AppTextStyles.logOut.copyWith(color: customTheme!.customTextColor2!),),
      value: themeMode,
      groupValue: selectedThemeMode,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      activeColor: theme.primaryColor,
      onChanged: (ThemeMode? value) {
        if (value != null) {
          callback(value);
        }
      },
    );
  }
}

class ButtonLogOut extends StatelessWidget {
  const ButtonLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.gainsborough),
          borderRadius: BorderRadius.circular(16)),
      child: Center(
          child: Text(
        AppTexts.logOut,
        style: AppTextStyles.logOut.copyWith(color: AppColors.orangeRedCrayola),
      )),
    );
  }
}

class ButtonProfile extends StatelessWidget {
  final String title;
  final String text;
  final bool icon;
  final Function onTap;
  final BuildContext context;

  const ButtonProfile({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final customTheme = Theme.of(context).extension<CustomThemeExtension>();
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: customTheme!.customTextColor3!,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.myAwardsTitle
                      .copyWith(color: customTheme.customTextColor1!),
                ),
                Text(
                  text,
                  style: AppTextStyles.myAwardsTitle
                      .copyWith(color: customTheme.customTextColor2!),
                ),
              ],
            ),
            if (icon)
              SvgPicture.asset(
                AppAssets.iconNextButton,
                colorFilter:
                    ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
              ),
          ],
        ),
      ),
    );
  }
}

class MyAwards extends StatelessWidget {
  final Color color;
  final List<String> listAwards;

  const MyAwards({super.key, required this.listAwards, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppTexts.myAwards,
          style: AppTextStyles.myAwardsTitle.copyWith(color: color),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16.0,
          children: List.generate(
            listAwards.length,
            (index) =>
                Text(listAwards[index], style: AppTextStyles.myAwardsIcons),
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final String avatarAssets;

  const Avatar({super.key, required this.avatarAssets});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              avatarAssets,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          Center(
            child: Text(
              AppTexts.editAvatar,
              style: AppTextStyles.avatarEdit.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
