import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/translation/app_translations.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../constans/app_constants.dart';

class TmtAppBarController {
  void Function()? resetTimer;
  void Function()? pauseTimer;
  void Function()? resumeTimer;
  void Function()? stopTimer;
}

class TmtCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isTestTypeA;
  final TmtAppBarController? controller;

  const TmtCustomAppBar({
    Key? key,
    required this.title,
    required this.isTestTypeA,
    this.controller,
  }) : super(key: key);

  @override
  State<TmtCustomAppBar> createState() => _TmtCustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TmtCustomAppBarState extends State<TmtCustomAppBar> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _startTimer();

    if (widget.controller != null) {
      widget.controller!.resetTimer = resetTimer;
      widget.controller!.pauseTimer = pauseTimer;
      widget.controller!.resumeTimer = resumeTimer;
      widget.controller!.stopTimer = stopTimer;
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
      _elapsedSeconds = 0;
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          centerTitle: false,
          leadingWidth: 30,
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            const SizedBox(width: 80),
            IconButton(
              icon: SvgPicture.asset(
                ImageVectorPath.help,
                width: 30,
                height: 30,
              ),
              onPressed: () {
                Get.toNamed(Routes.tmt_help);
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        Positioned.fill(
          child: SafeArea(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TMTGame.tmtGameTmtScreenAppBarTime.tr,
                    style: TextStyle(
                      color: AppColors.mainBlackText,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.fromLTRB(26, 7, 14, 7),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _formatTime(_elapsedSeconds),
                      style: const TextStyle(
                        color: AppColors.mainBlackText,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
}
