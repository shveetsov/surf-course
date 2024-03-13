import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_12/models/colored_card.dart';

import '../repositories/global_variables.dart';

class ColoredCardScreen extends StatefulWidget {
  final ColoredCard coloredCard;
  final Function(ColoredCard, BuildContext, TypeColor) copyColor;

  const ColoredCardScreen(
      {super.key, required this.coloredCard, required this.copyColor});

  @override
  State<ColoredCardScreen> createState() => _ColoredCardScreenState();
}

class _ColoredCardScreenState extends State<ColoredCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(widget.coloredCard.colorHex),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(
          color:
              Colors.white, // Здесь укажите желаемый цвет иконки кнопки назад
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Container(
            color: Color(widget.coloredCard.colorHex),
          )),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.coloredCard.name,
                    style: GlobalTextStyle.titleApp
                        .copyWith(color: GlobalColors.sapphireBlue),
                  ),
                  const SizedBox(height: 16),
                  ButtonColorHEX(
                    copyColor: widget.copyColor,
                    coloredCard: widget.coloredCard,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonColorRGB(
                          copyColor: widget.copyColor,
                          coloredCard: widget.coloredCard,
                          title: 'Red',
                          typeColor: TypeColor.r,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ButtonColorRGB(
                          copyColor: widget.copyColor,
                          coloredCard: widget.coloredCard,
                          title: 'Green',
                          typeColor: TypeColor.g,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ButtonColorRGB(
                          copyColor: widget.copyColor,
                          coloredCard: widget.coloredCard,
                          title: 'Blue',
                          typeColor: TypeColor.b,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ButtonColorHEX extends StatefulWidget {
  final ColoredCard coloredCard;
  final Function(ColoredCard, BuildContext, TypeColor) copyColor;

  const ButtonColorHEX(
      {super.key, required this.copyColor, required this.coloredCard});

  @override
  State<ButtonColorHEX> createState() => _ButtonColorHEXState();
}

class _ButtonColorHEXState extends State<ButtonColorHEX> {
  bool copy = false;
  final String assetsIconCopy = 'assets/icons/copy_icon.svg';

  Future<void> timeCopy() async {
    setState(() {
      copy = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      copy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.copyColor(widget.coloredCard, context, TypeColor.hex);
        timeCopy();
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1437394A), // Цвет тени
              blurRadius: 12, // Размытие тени; создаёт эффект "мягкости"
              offset: Offset(0, 12), // Смещение тени по X и Y
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hex',
              style: GlobalTextStyle.textColoredCard
                  .copyWith(color: GlobalColors.sapphireBlue),
            ),
            Row(
              children: [
                Text(
                  widget.coloredCard.copyColor(TypeColor.hex).substring(1),
                  style: GlobalTextStyle.textColoredCard
                      .copyWith(color: GlobalColors.sapphireBlue),
                ),
                const SizedBox(width: 8),
                AnimatedOpacity(
                    opacity: copy ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset(assetsIconCopy,
                        semanticsLabel: 'Скопировано')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonColorRGB extends StatefulWidget {
  final String title;
  final TypeColor typeColor;
  final ColoredCard coloredCard;
  final Function(ColoredCard, BuildContext, TypeColor) copyColor;

  const ButtonColorRGB(
      {super.key,
      required this.copyColor,
      required this.coloredCard,
      required this.title,
      required this.typeColor});

  @override
  State<ButtonColorRGB> createState() => _ButtonColorRGBState();
}

class _ButtonColorRGBState extends State<ButtonColorRGB> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.copyColor(widget.coloredCard, context, widget.typeColor);
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1437394A), // Цвет тени
              blurRadius: 12, // Размытие тени; создаёт эффект "мягкости"
              offset: Offset(0, 12), // Смещение тени по X и Y
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: GlobalTextStyle.textColoredCard
                  .copyWith(color: GlobalColors.sapphireBlue),
            ),
            const SizedBox(width: 16),
            Text(
              widget.coloredCard.copyColor(widget.typeColor),
              style: GlobalTextStyle.textColoredCard
                  .copyWith(color: GlobalColors.sapphireBlue),
            ),
          ],
        ),
      ),
    );
  }
}
