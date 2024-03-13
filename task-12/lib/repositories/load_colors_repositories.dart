import '../models/colored_card.dart';
import 'data.dart';
import 'dart:convert';

class LoadColorsRepositories {
  final List<ColoredCard> _coloredCards = [];

  Future<List<ColoredCard>> getColoredCards() async {
    final coloreds = jsonDecode(dataLocal) as Map<String, dynamic>;
    coloreds["colors"].forEach((color) {
      ColoredCard? coloredCard = ColoredCard.fromJson(color);
      if (coloredCard != null) {
        _coloredCards.add(coloredCard);
      }
    });
    await Future.delayed(const Duration(seconds: 1));
    return _coloredCards;
  }

}