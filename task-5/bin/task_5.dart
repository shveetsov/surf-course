// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

/// Человек
abstract class Person {
  String get name;

  DateTime get birthday;

  int get age;

  @override
  String toString() {
    return 'Имя: $name\nВозраст: $age\nДень рождения: ${DateFormat('dd.MM.yyyy').format(birthday)}\n';
  }
}

/// Футболист
class Footballer extends Person {
  @override
  final DateTime birthday;
  @override
  String name;
  @override
  int get age => DateTime.now().year - birthday.year; // возраст
  int goalsScored;
  int yellowCards;
  int redCards;

  Footballer(
      {required this.name,
        required this.birthday,
        this.goalsScored = 0,
        this.yellowCards = 0,
        this.redCards = 0});

  @override
  String toString() {
    String aboutMe = 'ФУТБОЛИСТ\n';
    aboutMe += super.toString();
    aboutMe +=
    'Забито голов: $goalsScored\nЖелтых карточек: $yellowCards\nКрасных карточек: $redCards\n';
    return aboutMe;
  }
}

/// Тренер
class Trainer extends Person {
  @override
  final DateTime birthday;
  @override
  String name;

  @override
  int get age => DateTime.now().year - birthday.year; // возраст
  int cups; // кол кубков
  int teachingExperience; // педагогический стаж

  Trainer({
    required this.name,
    required this.birthday,
    this.cups = 0,
    this.teachingExperience = 0,
  });

  @override
  String toString() {
    String aboutMe = 'ТРЕНЕР\n';
    aboutMe += super.toString();
    aboutMe += 'Кол. кубков: $cups\nПедагогический стаж: $teachingExperience\n';
    return aboutMe;
  }
}

void main() {
  Footballer footballer1 = Footballer(
    name: 'Илья',
    birthday: DateTime.utc(2000, 01, 01),
    goalsScored: 20,
    yellowCards: 1,
  );

  Trainer trainer =
  Trainer(name: 'Дмитрий', birthday: DateTime.utc(1982, 01, 01), cups: 4, teachingExperience: 14);
  print('$footballer1');
  print(trainer);
}
