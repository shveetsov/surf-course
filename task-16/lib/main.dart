import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_constants.dart';

void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('ru', 'RU'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode ||
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.grideperlevy,
        primaryColor: AppColors.ardentPink,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<Animal> _controllerButtonAnimal =
      ValueNotifier<Animal>(Animal.dog);

  final ValueNotifier<bool> _checkIfAllFieldsAreFilled =
      ValueNotifier<bool>(false);

  final _formKeyName = GlobalKey<FormState>();
  final _controllerName = TextEditingController();

  final _formKeyWeight = GlobalKey<FormState>();
  final _controllerWeight = TextEditingController();

  final _formKeyEmail = GlobalKey<FormState>();
  final _controllerEmail = TextEditingController();
  bool _checkEmail = false;

  String _controllerDateBirthday = '';

  bool _sendForm = false;

  bool _isCheckedRabies = false;
  String _controllerRabies = '';

  bool _isCheckedCovid = false;
  String _controllerCovid = '';

  bool _isCheckedMalaria = false;
  String _controllerMalaria = '';

  @override
  void initState() {
    super.initState();
    _controllerButtonAnimal.value = Animal.dog;
  }

  void updateButtonAnimal(Animal animal) {
    _controllerButtonAnimal.value = animal;
    if (animal == Animal.hamster || animal == Animal.parrot) {
      _isCheckedRabies = false;
      _isCheckedCovid = false;
      _isCheckedMalaria = false;
    }
  }

  void updateDateBirthday(String date) {
    _controllerDateBirthday = date;
  }

  void updateEmailCheck(bool email) {
    _checkEmail = email;
  }

  void checkIfAllFieldsAreFilled() {
    bool allFieldsFilled = _controllerName.text.length > 2 &&
        _controllerWeight.text.isNotEmpty &&
        _checkEmail &&
        _controllerDateBirthday.isNotEmpty;

    if (_isCheckedRabies) {
      allFieldsFilled = _controllerRabies.isNotEmpty;
    } else {
      _controllerRabies = '';
    }

    if (_isCheckedCovid) {
      allFieldsFilled = _controllerCovid.isNotEmpty;
    } else {
      _controllerCovid = '';
    }

    if (_isCheckedMalaria) {
      allFieldsFilled = _controllerMalaria.isNotEmpty;
    } else {
      _controllerMalaria = '';
    }
    Future.microtask(() => _checkIfAllFieldsAreFilled.value = allFieldsFilled);
  }

  void updateCheckedRabies(bool check) {
    setState(() {
      _isCheckedRabies = check;
      checkIfAllFieldsAreFilled();
    });
  }

  void updateDateRabies(String date) {
    _controllerRabies = date;
  }

  void updateCheckedCovid(bool check) {
    setState(() {
      _isCheckedCovid = check;
      checkIfAllFieldsAreFilled();
    });
  }

  void updateDateCovid(String date) {
    _controllerCovid = date;
  }

  void updateCheckedMalaria(bool check) {
    setState(() {
      _isCheckedMalaria = check;
      checkIfAllFieldsAreFilled();
    });
  }

  void updateDateMalaria(String date) {
    _controllerMalaria = date;
  }

  Future _send() async {
    setState(() {
      _sendForm = !_sendForm;
    });
    _checkIfAllFieldsAreFilled.value = false;
    await Future.delayed(const Duration(seconds: 2));
    _checkIfAllFieldsAreFilled.value = true;
    setState(() {
      _sendForm = !_sendForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListAnimal(
                    controllerButtonAnimal: _controllerButtonAnimal,
                    updateButtonAnimal: updateButtonAnimal,
                    sendForm: _sendForm),
                const SizedBox(height: 32),
                TextFieldName(
                  keyForm: _formKeyName,
                  controller: _controllerName,
                  sendForm: _sendForm,
                  checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
                ),
                const SizedBox(height: 16),
                TextFieldBirthday(
                  sendForm: _sendForm,
                  updateDateBirthday: updateDateBirthday,
                  checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
                  title: AppTexts.petsBirthday,
                ),
                const SizedBox(height: 16),
                TextFieldWeight(
                  keyForm: _formKeyWeight,
                  controller: _controllerWeight,
                  sendForm: _sendForm,
                  checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
                ),
                const SizedBox(height: 16),
                TextFieldEmail(
                  keyForm: _formKeyEmail,
                  controller: _controllerEmail,
                  sendForm: _sendForm,
                  checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
                  updateEmailCheck: updateEmailCheck,
                ),
                ValueListenableBuilder<Animal>(
                  valueListenable: _controllerButtonAnimal,
                  builder: (context, value, child) {
                    if (value == Animal.dog || value == Animal.cat) {
                      return MadeVaccinations(
                        isCheckedRabies: _isCheckedRabies,
                        updateCheckedRabies: updateCheckedRabies,
                        controllerRabies: _controllerRabies,
                        updateDateRabies: updateDateRabies,
                        sendForm: _sendForm,
                        checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
                        isCheckedCovid: _isCheckedCovid,
                        updateCheckedCovid: updateCheckedCovid,
                        controllerCovid: _controllerCovid,
                        updateDateCovid: updateDateCovid,
                        isCheckedMalaria: _isCheckedMalaria,
                        updateCheckedMalaria: updateCheckedMalaria,
                        controllerMalaria: _controllerMalaria,
                        updateDateMalaria: updateDateMalaria,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder<bool>(
                  valueListenable: _checkIfAllFieldsAreFilled,
                  builder: (context, value, child) {
                    bool check = value;
                    if (value) {
                      check = !_sendForm;
                    }
                    return GestureDetector(
                      onTap: () {
                        if (!_sendForm && value) {
                          _send();
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        decoration: BoxDecoration(
                          color: check
                              ? AppColors.ardentPink
                              : AppColors.veryPaleBlue,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.ardentPink
                                  .withOpacity(check ? 0.24 : 0),
                              // Цвет тени
                              blurRadius: 16,
                              // Размытие тени
                              offset: const Offset(
                                  0, 16), // Изменения положения тени
                            ),
                          ],
                        ),
                        child: Center(
                            child: !_sendForm
                                ? Text(
                                    AppTexts.send,
                                    style: AppTextStyles.text18
                                        .copyWith(color: AppColors.white),
                                  )
                                : const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  )),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Кнопка прививки
class CheckboxVaccinations extends StatelessWidget {
  final bool check;
  final Function(bool) updateChecked;
  final String iconPath;
  final String title;
  final String controller;
  final Function(String) updateDate;
  final bool sendForm;
  final Function checkIfAllFieldsAreFilled;

  const CheckboxVaccinations({
    super.key,
    required this.check,
    required this.iconPath,
    required this.updateChecked,
    required this.title,
    required this.controller,
    required this.updateDate,
    required this.sendForm,
    required this.checkIfAllFieldsAreFilled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (!sendForm) {
              updateChecked(!check);
            }
          },
          child: Container(
            width: double.infinity,
            color: Colors.white.withOpacity(0.001),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: check ? AppColors.ardentPink : AppColors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTextStyles.text16_24,
                ),
              ],
            ),
          ),
        ),
        check
            ? Column(
                children: [
                  const SizedBox(height: 16),
                  TextFieldBirthday(
                    updateDateBirthday: updateDate,
                    checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
                    sendForm: sendForm,
                    title: 'Дата последней прививки',
                  ),
                  const SizedBox(height: 16),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}

/// Список прививок
class MadeVaccinations extends StatelessWidget {
  final bool sendForm;
  final Function checkIfAllFieldsAreFilled;

  final bool isCheckedRabies;
  final Function(bool) updateCheckedRabies;
  final String controllerRabies;
  final Function(String) updateDateRabies;

  final bool isCheckedCovid;
  final Function(bool) updateCheckedCovid;
  final String controllerCovid;
  final Function(String) updateDateCovid;

  final bool isCheckedMalaria;
  final Function(bool) updateCheckedMalaria;
  final String controllerMalaria;
  final Function(String) updateDateMalaria;

  const MadeVaccinations({
    super.key,
    required this.isCheckedRabies,
    required this.updateCheckedRabies,
    required this.controllerRabies,
    required this.updateDateRabies,
    required this.sendForm,
    required this.checkIfAllFieldsAreFilled,
    required this.isCheckedCovid,
    required this.updateCheckedCovid,
    required this.controllerCovid,
    required this.updateDateCovid,
    required this.isCheckedMalaria,
    required this.updateCheckedMalaria,
    required this.controllerMalaria,
    required this.updateDateMalaria,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          AppTexts.vaccinationsAgainst,
          style: AppTextStyles.text24,
        ),
        const SizedBox(height: 16),
        CheckboxVaccinations(
          check: isCheckedRabies,
          updateChecked: updateCheckedRabies,
          iconPath: AppAssets.check,
          title: AppTexts.rabies,
          controller: controllerRabies,
          updateDate: updateDateRabies,
          sendForm: sendForm,
          checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
        ),
        CheckboxVaccinations(
          check: isCheckedCovid,
          updateChecked: updateCheckedCovid,
          iconPath: AppAssets.check,
          title: AppTexts.covida,
          controller: controllerCovid,
          updateDate: updateDateCovid,
          sendForm: sendForm,
          checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
        ),
        CheckboxVaccinations(
          check: isCheckedMalaria,
          updateChecked: updateCheckedMalaria,
          iconPath: AppAssets.check,
          title: AppTexts.malaria,
          controller: controllerMalaria,
          updateDate: updateDateMalaria,
          sendForm: sendForm,
          checkIfAllFieldsAreFilled: checkIfAllFieldsAreFilled,
        ),
      ],
    );
  }
}

/// Текстовое поле email
class TextFieldEmail extends StatefulWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController controller;
  final bool sendForm;
  final Function checkIfAllFieldsAreFilled;
  final Function(bool) updateEmailCheck;

  const TextFieldEmail({
    super.key,
    required this.keyForm,
    required this.controller,
    required this.sendForm,
    required this.checkIfAllFieldsAreFilled,
    required this.updateEmailCheck,
  });

  @override
  State<TextFieldEmail> createState() => _TextFieldEmailState();
}

class _TextFieldEmailState extends State<TextFieldEmail> {
  late FocusNode _focusNode;
  bool _error = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      // Если поле теряет фокус, вызываем валидацию формы
      if (!_focusNode.hasFocus) {
        setState(() {
          _error = widget.keyForm.currentState?.validate() ?? true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: widget.keyForm,
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        cursorColor: theme.primaryColor,
        style: _error
            ? AppTextStyles.text16_18.copyWith(color: AppColors.slateGrey)
            : AppTextStyles.text16_18
                .copyWith(color: AppColors.redOrangeCrayola),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          labelText: AppTexts.theOwnersMail,
          labelStyle: AppTextStyles.text16_24
              .copyWith(color: AppColors.cadetBlueCrayola),
          hintText: AppTexts.theOwnersMail,
          hintStyle: AppTextStyles.text16_18
              .copyWith(color: AppColors.cadetBlueCrayola),
          floatingLabelStyle:
              AppTextStyles.text12.copyWith(color: AppColors.cadetBlueCrayola),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorStyle:
              AppTextStyles.text12.copyWith(color: AppColors.redOrangeCrayola),
        ),
        enabled: !widget.sendForm,
        validator: (value) {
          widget.updateEmailCheck(false);
          widget.checkIfAllFieldsAreFilled();
          if (value == null || value.isEmpty) {
            return AppTexts
                .enterEmail; // "Пожалуйста, введите электронную почту"
          }
          // Регулярное выражение для проверки электронной почты
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = RegExp(pattern);

          if (!regex.hasMatch(value)) {
            return AppTexts.enterInvalidEmail;
          }
          widget.updateEmailCheck(true);
          widget.checkIfAllFieldsAreFilled();
          return null;
        },
      ),
    );
  }
}

/// Текстовое поле веса
class TextFieldWeight extends StatefulWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController controller;
  final bool sendForm;
  final Function checkIfAllFieldsAreFilled;

  const TextFieldWeight({
    super.key,
    required this.keyForm,
    required this.controller,
    required this.sendForm,
    required this.checkIfAllFieldsAreFilled,
  });

  @override
  State<TextFieldWeight> createState() => _TextFieldWeightState();
}

class _TextFieldWeightState extends State<TextFieldWeight> {
  late FocusNode _focusNode;
  bool _error = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      // Если поле теряет фокус, вызываем валидацию формы
      if (!_focusNode.hasFocus) {
        setState(() {
          _error = widget.keyForm.currentState?.validate() ?? true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: widget.keyForm,
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        cursorColor: theme.primaryColor,
        style: _error
            ? AppTextStyles.text16_18.copyWith(color: AppColors.slateGrey)
            : AppTextStyles.text16_18
                .copyWith(color: AppColors.redOrangeCrayola),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          labelText: AppTexts.weightKg,
          labelStyle: AppTextStyles.text16_24
              .copyWith(color: AppColors.cadetBlueCrayola),
          hintText: AppTexts.weightKg,
          hintStyle: AppTextStyles.text16_18
              .copyWith(color: AppColors.cadetBlueCrayola),
          floatingLabelStyle:
              AppTextStyles.text12.copyWith(color: AppColors.cadetBlueCrayola),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorStyle:
              AppTextStyles.text12.copyWith(color: AppColors.redOrangeCrayola),
        ),
        enabled: !widget.sendForm,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
        ],
        validator: (value) {
          widget.checkIfAllFieldsAreFilled();
          if (value == null || value.isEmpty) {
            return AppTexts.enterWeightKg;
          }
          // Попытка преобразовать строку в число.
          final number = int.tryParse(value);

          // Проверка, что значение является числом и больше или равно 0.
          if (number == null || number < 0) {
            return "Введите корректный вес";
          }
          return null;
        },
      ),
    );
  }
}

/// Поле выбора даты
class TextFieldBirthday extends StatefulWidget {
  final bool sendForm;
  final Function(String) updateDateBirthday;
  final Function checkIfAllFieldsAreFilled;
  final String title;

  const TextFieldBirthday({
    super.key,
    required this.sendForm,
    required this.updateDateBirthday,
    required this.checkIfAllFieldsAreFilled,
    required this.title,
  });

  @override
  State<TextFieldBirthday> createState() => _TextFieldBirthdayState();
}

class _TextFieldBirthdayState extends State<TextFieldBirthday> {
  DateTime? selectedDate;

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  Future<DateTime?> buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: widget.title,
      cancelText: 'Отмена',
      confirmText: 'Выбрать',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget
            .updateDateBirthday(DateFormat('dd.MM.yyyy').format(selectedDate!));
      });
      widget.checkIfAllFieldsAreFilled();
    }
    return null;
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                    widget.updateDateBirthday(
                        DateFormat('dd.MM.yyyy').format(selectedDate!));
                  });
                  widget.checkIfAllFieldsAreFilled();
                }
              },
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(1990),
              maximumDate: DateTime.now(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = widget.title;
    if (selectedDate != null) {
      formattedDate = DateFormat('dd.MM.yyyy').format(selectedDate!);
    }

    return GestureDetector(
      onTap: () async {
        if (!widget.sendForm) {
          _selectDate(context);
        }
      },
      child: Container(
        width: double.infinity,
        padding: formattedDate == widget.title
            ? const EdgeInsets.all(16)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formattedDate == widget.title
                ? const SizedBox()
                : Column(
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyles.text12
                            .copyWith(color: AppColors.cadetBlueCrayola),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
            Text(
              formattedDate,
              style: AppTextStyles.text16_18.copyWith(
                  color: formattedDate == widget.title
                      ? AppColors.cadetBlueCrayola
                      : AppColors.slateGrey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Текстовое поле имени
class TextFieldName extends StatefulWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController controller;
  final bool sendForm;
  final Function checkIfAllFieldsAreFilled;

  const TextFieldName({
    super.key,
    required this.keyForm,
    required this.controller,
    required this.sendForm,
    required this.checkIfAllFieldsAreFilled,
  });

  @override
  State<TextFieldName> createState() => _TextFieldNameState();
}

class _TextFieldNameState extends State<TextFieldName> {
  late FocusNode _focusNode;
  bool _error = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      // Если поле теряет фокус, вызываем валидацию формы
      if (!_focusNode.hasFocus) {
        setState(() {
          _error = widget.keyForm.currentState?.validate() ?? true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: widget.keyForm,
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        cursorColor: theme.primaryColor,
        style: _error
            ? AppTextStyles.text16_18.copyWith(color: AppColors.slateGrey)
            : AppTextStyles.text16_18
                .copyWith(color: AppColors.redOrangeCrayola),
        decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          labelText: AppTexts.petsName,
          labelStyle: AppTextStyles.text16_24
              .copyWith(color: AppColors.cadetBlueCrayola),
          hintText: AppTexts.petsName,
          hintStyle: AppTextStyles.text16_18
              .copyWith(color: AppColors.cadetBlueCrayola),
          floatingLabelStyle:
              AppTextStyles.text12.copyWith(color: AppColors.cadetBlueCrayola),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorStyle:
              AppTextStyles.text12.copyWith(color: AppColors.redOrangeCrayola),
        ),
        enabled: !widget.sendForm,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
        ],
        validator: (value) {
          widget.checkIfAllFieldsAreFilled();
          if (value == null || value.trim().isEmpty) {
            return AppTexts.enterPetsName;
          }

          if (value.trim().length < 3) {
            return "Имя должно содержать минимум 3 символа.";
          }
          return null;
        },
      ),
    );
  }
}

/// Список выбора животного
class ListAnimal extends StatelessWidget {
  final ValueNotifier<Animal> controllerButtonAnimal;
  final Function(Animal) updateButtonAnimal;
  final bool sendForm;

  const ListAnimal({
    super.key,
    required this.controllerButtonAnimal,
    required this.updateButtonAnimal,
    required this.sendForm,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controllerButtonAnimal,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonAnimal(
              title: AppTexts.dog,
              iconPath: AppAssets.dog,
              currentAnimal: value,
              animal: Animal.dog,
              updateButtonAnimal: updateButtonAnimal,
              sendForm: sendForm,
            ),
            ButtonAnimal(
              title: AppTexts.cat,
              iconPath: AppAssets.cat,
              currentAnimal: value,
              animal: Animal.cat,
              updateButtonAnimal: updateButtonAnimal,
              sendForm: sendForm,
            ),
            ButtonAnimal(
              title: AppTexts.parrot,
              iconPath: AppAssets.parrot,
              currentAnimal: value,
              animal: Animal.parrot,
              updateButtonAnimal: updateButtonAnimal,
              sendForm: sendForm,
            ),
            ButtonAnimal(
              title: AppTexts.hamster,
              iconPath: AppAssets.hamster,
              currentAnimal: value,
              animal: Animal.hamster,
              updateButtonAnimal: updateButtonAnimal,
              sendForm: sendForm,
            ),
          ],
        );
      },
    );
  }
}

/// Кнопка выбора животного
class ButtonAnimal extends StatelessWidget {
  final String title;
  final String iconPath;
  final Animal currentAnimal;
  final Animal animal;
  final bool sendForm;
  final Function(Animal) updateButtonAnimal;

  const ButtonAnimal({
    super.key,
    required this.title,
    required this.iconPath,
    required this.currentAnimal,
    required this.animal,
    required this.updateButtonAnimal,
    required this.sendForm,
  });

  @override
  Widget build(BuildContext context) {
    final check = animal == currentAnimal;

    return GestureDetector(
      onTap: () {
        if (!sendForm) updateButtonAnimal(animal);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: check ? AppColors.ardentPink : AppColors.white,
              shape: BoxShape.rectangle,
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                  check ? AppColors.white : AppColors.slateGrey,
                  BlendMode.srcIn),
              height: 32,
              width: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.text12.copyWith(color: AppColors.slateGrey),
          )
        ],
      ),
    );
  }
}
