import 'package:flutter/material.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_game_board_controller.dart';

import '../../../../config/themes/AppColors.dart';

void main() {
  runApp(const MaterialApp(home: TmtTestPage()));
}

class TmtTestPage extends StatefulWidget {
  const TmtTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DotToDotScreenState();
  }
}

class _DotToDotScreenState extends State<TmtTestPage> {
  final TmtGameBoardController _boardController = TmtGameBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.testTMTBackground,
      appBar: AppBar(
        title: const Text('TMT Test'),
        actions: [
          IconButton(
            onPressed: () {
              _boardController.regenerateCircles();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _boardController,
    );
  }
}
