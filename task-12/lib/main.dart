import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_12/models/bloc/color_palette_bloc.dart';
import 'package:task_12/models/colored_card.dart';
import 'package:task_12/repositories/global_variables.dart';

import 'screens/colored_card_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Эксклюзивная палитра Colored Box',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  final _colorPaletteBloc = ColorPaletteBloc();

  @override
  void initState() {
    _colorPaletteBloc.add(LoadColorPalette());
    super.initState();
  }

  void copyColor(ColoredCard coloredCard, BuildContext context, TypeColor typeColor) {
    _colorPaletteBloc
        .add(CopyColorPalette(coloredCard: coloredCard, context: context, typeColor: typeColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Эксклюзивная палитра «Colored Box»',
                style: GlobalTextStyle.titleApp
                    .copyWith(color: GlobalColors.sapphireBlue),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<ColorPaletteBloc, ColorPaletteState>(
              bloc: _colorPaletteBloc,
              builder: (context, state) {
                if (state is ColorPaletteLoaded) {
                  final double heightCard =
                      (MediaQuery.of(context).size.width - 32 - 22) / 3;
                  return GridColorCards(
                    height: heightCard,
                    coloredCards: state.coloredCards,
                    copyColor: copyColor,
                  );
                }

                if (state is ColorPaletteLoadedFailed) {
                  return const Center(
                    child: Text('Ало, где интернет???'),
                  );
                }

                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const SizedBox(height: 33),
          ],
        ),
      ),
    );
  }
}

class GridColorCards extends StatelessWidget {
  final List<ColoredCard> coloredCards;
  final double height;
  final Function(ColoredCard, BuildContext, TypeColor) copyColor;

  const GridColorCards(
      {super.key,
      required this.height,
      required this.coloredCards,
      required this.copyColor});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      crossAxisSpacing: 22,
      mainAxisSpacing: 40,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: (1 / 1.5),
      children: List<Widget>.generate(
        coloredCards.length,
        (index) => ColorCard(
          coloredCard: coloredCards[index],
          height: height,
          copyColor: copyColor,
        ),
      ),
    );
  }
}

class ColorCard extends StatefulWidget {
  final ColoredCard coloredCard;
  final double height;
  final Function(ColoredCard, BuildContext, TypeColor) copyColor;

  const ColorCard(
      {super.key,
      required this.coloredCard,
      required this.height,
      required this.copyColor});

  @override
  State<ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends State<ColorCard> {
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
      onLongPress: () {
        widget.copyColor(widget.coloredCard, context, TypeColor.hex);
        timeCopy();
      },
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ColoredCardScreen(coloredCard: widget.coloredCard, copyColor: widget.copyColor,)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: Color(widget.coloredCard.colorHex),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.coloredCard.name,
            style: GlobalTextStyle.titleColoredCard
                .copyWith(color: GlobalColors.sapphireBlue),
          ),
          Row(
            children: [
              Text(
                widget.coloredCard.value,
                style: GlobalTextStyle.titleColoredCard
                    .copyWith(color: GlobalColors.sapphireBlue),
              ),
              const SizedBox(width: 4),
              AnimatedOpacity(
                  opacity: copy ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(assetsIconCopy, semanticsLabel: 'Скопировано')),
            ],
          ),
        ],
      ),
    );
  }
}
