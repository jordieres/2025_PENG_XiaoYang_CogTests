import 'package:flutter/material.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_painter.dart';

import '../controllers/random_grid_sampler.dart';

/// This class manager logic of tmt test
class TmtGameBoardController extends StatefulWidget {
  const TmtGameBoardController({super.key});

  static const int CIRCLE_NUMBER = 25;
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
  final List<Offset> _dragPath = [];
  final List<List<Offset>> _paths = [];

  double _constraintsMaxWidth = 0;
  double _constraintsMaxHeight = 0;
  Offset? _lastErrorCircle;

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
    _paths.clear();
    _dragPath.clear();
    _lastErrorCircle = null;

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
      _dragPath.add(details.localPosition);
    });

    if (_nextCircleIndex >= TmtGameBoardController.CIRCLE_NUMBER) {
      _showCompletionDialog();
      return;
    }


      for (int i = 0; i < _circles.length; i++) {
        double distance = (details.localPosition - _circles[i]).distance;

        if (i == _nextCircleIndex &&
            distance < TmtGameBoardController.CONNECT_DISTANCE) {
          setState(() {
            _connectedCircles.add(_circles[i]);
            _nextCircleIndex++;
            _currentDragPosition = _circles[i];

            _paths.add(List.from(_dragPath));
            _dragPath.clear();
            _lastErrorCircle = null;
          });
          return;
        }

        if (i != _nextCircleIndex &&
            distance < TmtGameBoardController.CONNECT_DISTANCE) {
          setState(() {
            _dragPath.clear();
            _lastErrorCircle = _circles[i];
          });
          return;
        }
      }
    }



  void _onPanEnd(DragEndDetails details) {
    setState(() {
      if (!_connectedCircles.contains(_currentDragPosition)) {
        _dragPath.clear();
      }
      _currentDragPosition =
          _connectedCircles.isNotEmpty ? _connectedCircles.last : null;
    });
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
                _generateRandomCircle();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
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
                  painter: TmtPainter(_circles, _connectedCircles,
                      _currentDragPosition, _dragPath, _paths),
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
