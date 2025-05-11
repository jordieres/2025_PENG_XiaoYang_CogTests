import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../domain/entities/tmt_game/tmt_game_variable.dart';

class TmtCountdownComponent extends StatefulWidget {
  final VoidCallback onCountdownComplete;
  final String testType;

  const TmtCountdownComponent({
    super.key,
    required this.onCountdownComplete,
    required this.testType,
  });

  @override
  State<TmtCountdownComponent> createState() => _TmtCountdownComponentState();
}

class _TmtCountdownComponentState extends State<TmtCountdownComponent>
    with SingleTickerProviderStateMixin {
  int _count = TmtGameVariables.TMT_COUNTDOWN_TO_START_DURATION;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _timer;

  bool get isDarkMode => Get.isDarkMode;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _startCountdown();
  }

  void _startCountdown() {
    _animationController.forward(from: 0.0);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_count > 1) {
        setState(() {
          _count--;
        });
        _animationController.forward(from: 0.0);
      } else {
        _timer?.cancel();
        widget.onCountdownComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode
          ? AppColors.testTMTBoardBackgroundDark.withAlpha(230)
          : AppColors.testTMTBoardBackground.withAlpha(230),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.testType,
              style: TextStyleBase.h1,
            ),
            const SizedBox(height: 16),
            Text(
              TMTGameText.tmtGameCountdownMessage.tr,
              style: TextStyleBase.bodyM,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.secondaryBlueDark
                            : AppColors.secondaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$_count',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? AppColors.darkText
                                : AppColors.mainBlackText,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
