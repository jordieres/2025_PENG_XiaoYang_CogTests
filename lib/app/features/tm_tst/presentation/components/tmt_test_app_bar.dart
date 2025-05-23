import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/translation/app_translations.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../constans/app_constants.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../screens/tmt_test_help.dart';

class TmtAppBarController {
  void Function()? resetTimer;
  void Function()? pauseTimer;
  void Function()? resumeTimer;
  void Function()? stopTimer;
  void Function(int initialSeconds)? setStartTime;
}

class TmtCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isTestTypeA;
  final TmtAppBarController? controller;
  final int initialSeconds;

  const TmtCustomAppBar({
    Key? key,
    required this.title,
    required this.isTestTypeA,
    this.controller,
    this.initialSeconds = 0,
  }) : super(key: key);

  @override
  State<TmtCustomAppBar> createState() => _TmtCustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TmtCustomAppBarState extends State<TmtCustomAppBar>
    with NavigationMixin {
  Timer? _timer;
  late int _elapsedSeconds;
  bool _isPaused = false;
  late int _initialSeconds;

  bool get isDarkMode => Get.isDarkMode;

  @override
  void initState() {
    super.initState();
    _initialSeconds = widget.initialSeconds;
    _elapsedSeconds = widget.initialSeconds;
    _startTimer();

    if (widget.controller != null) {
      widget.controller!.resetTimer = resetTimer;
      widget.controller!.pauseTimer = pauseTimer;
      widget.controller!.resumeTimer = resumeTimer;
      widget.controller!.stopTimer = stopTimer;
      widget.controller!.setStartTime = setStartTime;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void resetTimer() {
    setState(() {
      _elapsedSeconds = _initialSeconds;
      _isPaused = false;
    });
  }

  void pauseTimer() {
    setState(() {
      _isPaused = true;
    });
  }

  void resumeTimer() {
    setState(() {
      _isPaused = false;
    });
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
    });
  }

  void setStartTime(int initialSeconds) {
    setState(() {
      _initialSeconds = initialSeconds;
      _elapsedSeconds = initialSeconds;
      _isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> defaultActions = [
      const SizedBox(width: 80),
      IconButton(
        icon: isDarkMode
            ? SvgPicture.asset(
          ImageVectorPath.help,
          width: 30,
          height: 30,
          colorFilter: ColorFilter.mode(
            AppColors.darkText,
            BlendMode.srcIn,
          ),
        )
            : SvgPicture.asset(
          ImageVectorPath.help,
          width: 30,
          height: 30,
        ),
        onPressed: () {
          _navigateToHelpScreen();
        },
      ),
      const SizedBox(width: 8),
    ];

    return Stack(
      children: [
        CustomAppBar(
          title: widget.title,
          centerTitle: false,
          actions: defaultActions,
        ),
        Positioned.fill(
          child: SafeArea(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 8),
                  Text(
                    TMTGameText.tmtGameTmtScreenAppBarTime.tr,
                    style: AppTextStyle.appBarTitle,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.fromLTRB(26, 7, 26, 7),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.secondaryBlueDark
                          : AppColors.secondaryBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _formatTime(_elapsedSeconds),
                      style: AppTextStyle.appBarTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToHelpScreen() {
    final helpMode =
    widget.isTestTypeA ? TmtHelpMode.TMT_TEST_A : TmtHelpMode.TMT_TEST_B;
    tmtTestToHelp(helpMode);
  }
}