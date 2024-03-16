import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_12/models/colored_card.dart';

import '../repositories/global_variables.dart';

class ColoredCardScreen extends StatelessWidget {
  final ColoredCard coloredCard;
  final Function(ColoredCard, BuildContext, TypeColor) copyColor;

  const ColoredCardScreen(
      {super.key, required this.coloredCard, required this.copyColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(coloredCard.colorHex),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(
          color:
              AppColors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Container(
            color: Color(coloredCard.colorHex),
          )),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coloredCard.name,
                    style: AppTextStyle.titleApp,
                  ),
                  const SizedBox(height: 16),
                  ButtonColorHEX(
                    copyColor: copyColor,
                    coloredCard: coloredCard,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonColorRGB(
                          copyColor: copyColor,
                          coloredCard: coloredCard,
                          title: 'Red',
                          typeColor: TypeColor.r,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ButtonColorRGB(
                          copyColor: copyColor,
                          coloredCard: coloredCard,
                          title: 'Green',
                          typeColor: TypeColor.g,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ButtonColorRGB(
                          copyColor: copyColor,
                          coloredCard: coloredCard,
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
              color: Color(0x1437394A),
              blurRadius: 12,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hex',
              style: AppTextStyle.textColoredCard,
            ),
            Row(
              children: [
                Text(
                  widget.coloredCard.copyColor(TypeColor.hex).substring(1),
                  style: AppTextStyle.textColoredCard,
                ),
                if (copy)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: AnimatedOpacity(
                      opacity: copy ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: SvgPicture.asset(AppAssets.assetsIconCopy,
                          semanticsLabel: 'Скопировано'),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonColorRGB extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        copyColor(coloredCard, context, typeColor);
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1437394A),
              blurRadius: 12,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.textColoredCard,
            ),
            Text(
              coloredCard.copyColor(typeColor),
              style: AppTextStyle.textColoredCard,
            ),
          ],
        ),
      ),
    );
  }
}
