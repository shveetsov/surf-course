import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/api_repositories.dart';

part 'magic_ball_event.dart';
part 'magic_ball_state.dart';

class MagicBallBloc extends Bloc<MagicBallEvent, MagicBallState> {
  MagicBallBloc() : super(MagicBallInitial()) {
    final ApiRepositories apiRepositories = ApiRepositories();
    bool stop = false;

    Future<void> handleLoadMagicBall(event, emit) async {
      stop = false;
      emit(MagicBallLoading());
      final title = await apiRepositories.getRandomString();

      if (!stop && title != 'Error. Try again') {
        emit(MagicBallLoaded(title: title));
      } else if (title == 'Error. Try again') {
        emit(MagicBallFailed(title: title));
      }
    }

    Future<void> handleStopMagicBall(event, emit) async {
      emit(MagicBallStop());
      stop = true;
    }

    on<LoadMagicBall>(handleLoadMagicBall);

    on<StopMagicBall>(handleStopMagicBall);
  }
}