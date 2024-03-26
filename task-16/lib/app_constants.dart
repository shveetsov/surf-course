import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color slateGrey = Color(0xFF414657);
  static const Color cadetBlueCrayola = Color(0xFFAFB2BC);
  static const Color grideperlevy = Color(0xFFEAECEB);
  static const Color veryPaleBlue = Color(0xFFD3D5D8);
  static const Color ardentPink = Color(0xFFFF8087);
  static const Color redOrangeCrayola = Color(0xFFFD4C56);
}

abstract class AppTexts {
  static const dog = 'Собака';
  static const cat = 'Кошка';
  static const parrot = 'Попугай';
  static const hamster = 'Хомяк';
  static const petsName = 'Имя питомца';
  static const petsBirthday = 'День рождения питомца';
  static const weightKg = 'Вес, кг';
  static const theOwnersMail = 'Почта хозяина';
  static const vaccinationsAgainst = 'Сделаны прививки от:';
  static const rabies = 'бешенства';
  static const covida = 'ковида';
  static const malaria = 'малярии';
  static const dateLastVaccination = 'Дата последней прививки';
  static const send = 'Отправить';
  static const enterPetsName = 'Укажите имя питомца от 3 до 20 символов';
  static const enterWeightKg = 'Укажите вес, больше 0 кг';
  static const enterEmail = 'Пожалуйста, введите электронную почту';
  static const enterInvalidEmail = 'Неверный формат электронной почты';
}

abstract class AppAssets {
  static const dog = 'assets/icons/dog.svg';
  static const cat = 'assets/icons/cat.svg';
  static const parrot = 'assets/icons/parrot.svg';
  static const hamster = 'assets/icons/hamster.svg';
  static const check = 'assets/icons/check.svg';
}

abstract class AppTextStyles {
  static TextStyle text12 = const TextStyle(fontSize: 12, height: 1.33, fontWeight: FontWeight.w400);
  static TextStyle text16_18 = const TextStyle(fontSize: 16, height: 1.12, fontWeight: FontWeight.w400);
  static TextStyle text16_24 = const TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w400);
  static TextStyle text18 = const TextStyle(fontSize: 18, height: 1.33, fontWeight: FontWeight.w600);
  static TextStyle text24 = const TextStyle(fontSize: 24, height: 1.33, fontWeight: FontWeight.w600);
}

enum Animal {
  dog(AppTexts.dog),
  cat(AppTexts.cat),
  parrot(AppTexts.parrot),
  hamster(AppTexts.hamster);

  const Animal(this.name);
  final String name;

  @override
  String toString() => name;
}