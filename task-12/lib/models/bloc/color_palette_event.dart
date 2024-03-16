part of 'color_palette_bloc.dart';

class ColorPaletteEvent {}

class LoadColorPalette extends ColorPaletteEvent {}

class CopyColorPalette extends ColorPaletteEvent {
  final ColoredCard coloredCard;
  final BuildContext context;
  final TypeColor typeColor;
  final Function copySnackBar;

  CopyColorPalette({required this.coloredCard, required this.context, required this.typeColor,required this.copySnackBar});
}
