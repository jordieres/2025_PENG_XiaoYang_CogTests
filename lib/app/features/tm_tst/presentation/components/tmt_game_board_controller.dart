import 'package:flutter/material.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_painter.dart';

import '../controllers/random_grid_sampler.dart';

/// This class manager logic of tmt test
class TmtGameBoardController extends StatefulWidget {
  const TmtGameBoardController({super.key});

  static const int CIRCLE_NUMBER = 15;
  static const double TOUCH_MARGIN = 5;
  static const int BOARD_MARGIN = 10;
  static const double CONNECT_DISTANCE = TmtPainter.circleRadius;
  static const double safeDistance =
      TmtPainter.circleRadius * 2 + TOUCH_MARGIN + BOARD_MARGIN * 2;

  @override
  _TmtGameBoardControllerState createState() => _TmtGameBoardControllerState();
}

class _TmtGameBoardControllerState extends State<TmtGameBoardController> {
  late List<Offset> _circles = [];
  final List<Offset> _connectedCircles = [];
  Offset? _currentDragPosition;
  int _nextCircleIndex = 0;

  double _constraintsMaxWidth = 0;
  double _constraintsMaxHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _generateRandomCircle() {
    _circles.clear();
    _connectedCircles.clear();
    _nextCircleIndex = 0;

    final double minX =
        TmtPainter.circleRadius + TmtGameBoardController.BOARD_MARGIN;

    final double maxX = _constraintsMaxWidth -
        TmtPainter.circleRadius -
        TmtGameBoardController.BOARD_MARGIN;

    final double minY =
        TmtPainter.circleRadius + TmtGameBoardController.BOARD_MARGIN;

    final double maxY = _constraintsMaxHeight -
        TmtPainter.circleRadius -
        TmtGameBoardController.BOARD_MARGIN;

    /*_circles = SimpleAlgorithm(
            minDistance: TmtGameBoardController.safeDistance,
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY)
        .generatePoints(
      TmtGameBoardController.CIRCLE_NUMBER,
    );*/

    _circles = RandomGridSampler(
            minDistance: TmtGameBoardController.safeDistance,
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY)
        .generatePoints(
      TmtGameBoardController.CIRCLE_NUMBER,
    );

  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentDragPosition = details.localPosition;
    });

    //all circles are connected
    if (_nextCircleIndex >= TmtGameBoardController.CIRCLE_NUMBER) return;

    final Offset target = _circles[_nextCircleIndex];
    final double distance = (details.localPosition - target).distance;

    if (distance < TmtGameBoardController.CONNECT_DISTANCE) {
      setState(() {
        _connectedCircles.add(target);
        _nextCircleIndex++;
        _currentDragPosition = target;

        if (_nextCircleIndex == TmtGameBoardController.CIRCLE_NUMBER) {
          _showCompletionDialog();
        }
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You have connected all the dots!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                //_generateRandomCircle();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  ///
  /// When the user lifts their finger,
  /// disappear drag line and
  /// assign the last connected circle to the current drag position
  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _currentDragPosition =
          _connectedCircles.isNotEmpty ? _connectedCircles.last : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_constraintsMaxWidth != constraints.maxWidth ||
            _constraintsMaxHeight != constraints.maxHeight) {
          _constraintsMaxWidth = constraints.maxWidth;
          _constraintsMaxHeight = constraints.maxHeight;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _generateRandomCircle();
            });
          });
        }
        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: TmtPainter(
                      _circles, _connectedCircles, _currentDragPosition),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _generateRandomCircle();
                });
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
