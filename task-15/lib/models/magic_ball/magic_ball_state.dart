part of 'magic_ball_bloc.dart';

class MagicBallState {}

class MagicBallInitial extends MagicBallState {}

class MagicBallLoaded extends MagicBallState {
  final String title;

  MagicBallLoaded({required this.title});
}

class MagicBallLoading extends MagicBallState {}

class MagicBallStop extends MagicBallState {}

class MagicBallFailed extends MagicBallState {
  final String title;
  final Color color = const Color(0x4DFF0000);

  MagicBallFailed({required this.title});
}