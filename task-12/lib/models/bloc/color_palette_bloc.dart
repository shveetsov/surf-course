import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/load_colors_repositories.dart';
import '../colored_card.dart';

part 'color_palette_event.dart';

part 'color_palette_state.dart';

class ColorPaletteBloc extends Bloc<ColorPaletteEvent, ColorPaletteState> {
  ColorPaletteBloc() : super(ColorPaletteInitial()) {
    final LoadColorsRepositories loadColorsRepositories =
        LoadColorsRepositories();

    Future<void> handleLoadColorPalette(event, emit) async {
      try {
        emit(ColorPaletteLoading());
        List<ColoredCard> coloredCards =
            await loadColorsRepositories.getColoredCards();
        emit(ColorPaletteLoaded(coloredCards: coloredCards));
      } catch (e) {
        emit(ColorPaletteLoadedFailed());
      }
    }

    Future<void> handleCopyColorPalette(event, emit) async {
      final String copy = event.coloredCard.copyColor(event.typeColor);
      event.copySnackBar(copy, event.coloredCard.colorHex);
    }

    on<LoadColorPalette>(handleLoadColorPalette);

    on<CopyColorPalette>(handleCopyColorPalette);
  }
}
