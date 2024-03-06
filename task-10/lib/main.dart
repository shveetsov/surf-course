import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class StyleTextGlobal {
  static const appBar = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontFamily: 'Comicoro',
      height: 0.8);
  static const title = TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontFamily: 'Comicoro',
      height: 0.8);
  static const text = TextStyle(fontSize: 14, color: Colors.black);
}

abstract class MocksGlobal {
  static const appBar = 'Визитка';

  static const avatarPath = 'assets/images/avatar.jpg';

  static const about = 'О себе';
  static const hobbies = 'Увлечения';
  static const experienceDevelopment = 'Опыт в разработке';

  static const aboutText =
      'Меня зовут Кирилл. Я окончил университет на красный диплом по направлению «Прикладная математика и информатика». Живу на Камчатке.';
  static const hobbiesText =
      'Люблю на горных лыжах, велике кататься. Естественно, программировать, дизайнить сайты или мобильные приложения.';
  static const experienceDevelopmentText =
      'Изучал C++, С#, Golang, Dart. Делал пару игр на Unity и опубликовывал в Google Play Market. Писал диплом по генетической генерации расписания для университета на Dart. Также были попытки написать программу для раскроя листов Guillotine Algorithm, Maximal Rectangles Algorithm и прочие алгоритмы.';
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MocksGlobal.appBar,
          style: StyleTextGlobal.appBar.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 10,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainPersonalDataSection(
                name: 'Швецов Кирилл Анатольевич',
                radius: 50,
                imgPath: MocksGlobal.avatarPath,
              ),
              SizedBox(
                height: 16,
              ),
              IconTitle(
                title: MocksGlobal.about,
                text: MocksGlobal.aboutText,
                iconPath: 'assets/icons/profile_info.svg',
              ),
              SizedBox(
                height: 16,
              ),
              IconTitle(
                title: MocksGlobal.hobbies,
                text: MocksGlobal.hobbiesText,
                iconPath: 'assets/icons/desktop.svg',
              ),
              SizedBox(
                height: 16,
              ),
              IconTitle(
                title: MocksGlobal.experienceDevelopment,
                text: MocksGlobal.experienceDevelopmentText,
                iconPath: 'assets/icons/code.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTitle extends StatelessWidget {
  final String iconPath;
  final String title;
  final String text;

  const IconTitle({
    super.key,
    required this.iconPath,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.15)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(iconPath, semanticsLabel: 'About'),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  title,
                  style: StyleTextGlobal.title,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: StyleTextGlobal.text,
          ),
        ],
      ),
    );
  }
}

class MainPersonalDataSection extends StatelessWidget {
  final String name;
  final double radius;
  final String imgPath;

  const MainPersonalDataSection({
    super.key,
    required this.name,
    required this.imgPath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(
          radius: radius,
          imgPath: imgPath,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            name,
            style: StyleTextGlobal.title,
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final double radius;
  final String imgPath;

  const Avatar({
    super.key,
    required this.imgPath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black.withOpacity(0.25),
          width: 0.3,
        ),
        image: DecorationImage(
          image: AssetImage(imgPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
