
import 'package:flutter/material.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_game_board_controller.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMT Test'),
      ),
      body: const TmtGameBoardController(),
    );
  }
}