import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/load_colors_repositories.dart';
import '../colored_card.dart';

part 'color_palette_event.dart';

part 'color_palette_state.dart';

class ColorPaletteBloc extends Bloc<ColorPaletteEvent, ColorPaletteState> {
  ColorPaletteBloc() : super(ColorPaletteInitial()) {
    final LoadColorsRepositories loadColorsRepositories =
        LoadColorsRepositories();
    on<LoadColorPalette>((event, emit) async {
      try {
        emit(ColorPaletteLoading());
        List<ColoredCard> coloredCards =
            await loadColorsRepositories.getColoredCards();
        emit(ColorPaletteLoaded(coloredCards: coloredCards));
      } catch (e) {
        emit(ColorPaletteLoadedFailed());
      }
    });

    on<CopyColorPalette>((event, emit) async {

      final String copy = event.coloredCard.copyColor(event.typeColor);
      
      await Clipboard.setData(
          ClipboardData(text: copy))
          .then(
            (_) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              padding: const EdgeInsets.all(16),
              duration: const Duration(milliseconds: 500),
              content: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(copy),
                      const SizedBox(width: 8),
                      Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Color(event.coloredCard.colorHex),
                              borderRadius: BorderRadius.circular(8)))
                    ],
                  ))));
        },
      );
    });
  }
}
