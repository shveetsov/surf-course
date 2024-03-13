part of 'color_palette_bloc.dart';

class ColorPaletteState {}

class ColorPaletteInitial extends ColorPaletteState {}

class ColorPaletteLoading extends ColorPaletteState {}

class ColorPaletteLoaded extends ColorPaletteState {
  final List<ColoredCard> coloredCards;

  ColorPaletteLoaded({required this.coloredCards});
}

class ColorPaletteLoadedFailed extends ColorPaletteState {

}