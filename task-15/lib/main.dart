import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shake/shake.dart';
import 'package:task_15/app_constants.dart';

import 'models/magic_ball/magic_ball_bloc.dart';

void main() {
  runApp(const MagicBallApp());
}

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _magicBallBloc = MagicBallBloc();
  double _scale = 1.0;
  double _opacity = 1.0;
  Curve _curve = Curves.easeOutQuint;
  double _opacityBg = 0;
  final Duration _duration = const Duration(milliseconds: 300);
  late ShakeDetector detector;

  @override
  void initState() {
    detector = ShakeDetector.autoStart(
        onPhoneShake: () {
          _toggleZoom();
        }
    );
    super.initState();
  }

  void _toggleZoom() {
    setState(() {
      if (_opacity == 1) {
        _magicBallBloc.add(LoadMagicBall());
      } else {
        _magicBallBloc.add(StopMagicBall());
      }
      _scale = _scale == 1.0 ? 2.5 : 1.0;
      _opacity = _opacity == 1.0 ? 0 : 1.0;
      _curve = _opacity == 1.0 ? Curves.easeInQuint : Curves.easeOutQuint;
      _opacityBg = _opacityBg == 1.0 ? 0 : 1.0;
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleZoom,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.deepPurpleBlue,
                AppColors.darkBlue,
              ],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: AnimatedScale(
                  scale: _scale,
                  duration: _duration,
                  curve: Curves.easeInOut,
                  child: Image.asset(
                      AppAssets.bg), // Замените URL на вашу картинку
                ),
              ),
              Positioned(
                bottom: 56,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  curve: _curve,
                  duration: _duration,
                  child: Text(
                    AppTexts.clickOnTheBall,
                    style: AppTextStyles.clickOnTheBall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _opacityBg,
                duration: _duration,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.deepPurpleBlue.withOpacity(0), // Цвет сверху
                        AppColors.darkBlue, // Цвет снизу
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<MagicBallBloc, MagicBallState>(
                  bloc: _magicBallBloc,
                  builder: (context, state) {
                    if (state is MagicBallLoaded) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            state.title,
                            style: AppTextStyles.textMagicBall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    if (state is MagicBallLoading) {
                      return const Center(child: DotsLoadingIndicator());
                    }

                    if (state is MagicBallFailed) {
                      return Container(
                        height: double.infinity,
                        color: state.color,
                        child: Center(
                          child: Text(
                            state.title,
                            style: AppTextStyles.textMagicBall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class DotsLoadingIndicator extends StatefulWidget {
  const DotsLoadingIndicator({super.key});

  @override
  State<DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<DotsLoadingIndicator> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => buildDot(index)),
    );
  }

  Widget buildDot(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final scale = 1.0 + 0.5 * (calculateValue(index) <= 0.5 ? calculateValue(index) : 1 - calculateValue(index));
        return Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  double calculateValue(int index) {
    final value = (_animationController.value - index / 3).abs() % 1;
    return value;
  }
}
