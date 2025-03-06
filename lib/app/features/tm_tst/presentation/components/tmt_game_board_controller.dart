import 'package:flutter/material.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_painter.dart';

import '../../data/datasources/random_grid_sampler.dart';
import '../../domian/usecases/tmt_game_calculate.dart';
import '../../domian/entities/tmt_game_variable.dart';

/// This class manager logic of tmt test
class TmtGameBoardController extends StatefulWidget {
  const TmtGameBoardController({super.key});

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
  bool _isDragging = false;

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
    _isDragging = false;

    _circles = RandomGridSampler(
            minDistance: TmtGameVariables.safeDistance,
            minX: TmtGameCalculate.getBoardMinX(),
            maxX: TmtGameCalculate.getBoardMaxX(_constraintsMaxWidth),
            minY: TmtGameCalculate.getBoardMinY(),
            maxY: TmtGameCalculate.getBoardMaxY(_constraintsMaxHeight))
        .generatePoints(
      TmtGameVariables.CIRCLE_NUMBER,
    );
  }

  void _onPanStart(DragStartDetails details) {
    if (_nextCircleIndex == 0) {
      double distance = (details.localPosition - _circles[0]).distance;
      if (distance < TmtGameVariables.CONNECT_DISTANCE) {
        setState(() {
          _isDragging = true;
          _connectedCircles.add(_circles[0]);
          _nextCircleIndex = 1;
          _currentDragPosition = _circles[0];
          _dragPath.clear();
          _dragPath.add(_circles[0]);
        });
      }
    } else if (_nextCircleIndex < TmtGameVariables.CIRCLE_NUMBER) {
      double distance =
          (details.localPosition - _connectedCircles.last).distance;
      if (distance < TmtGameVariables.CONNECT_DISTANCE) {
        setState(() {
          _isDragging = true;
          _currentDragPosition = _connectedCircles.last;
          _dragPath.clear();
          _dragPath.add(_connectedCircles.last);
        });
      }
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    setState(() {
      _currentDragPosition = details.localPosition;
      _dragPath.add(details.localPosition);
    });

    if (_nextCircleIndex >= TmtGameVariables.CIRCLE_NUMBER) {
      _showCompletionDialog();
      return;
    }

    for (int i = 0; i < _circles.length; i++) {
      if (i == _nextCircleIndex || _connectedCircles.contains(_circles[i])) {
        continue;
      }

      //check if connect with other circle that is not next circle
      if (TmtGameCalculate.isConnectWithCircle(
          details.localPosition, _circles[i])) {
        setState(() {
          _isDragging = false;
          _dragPath.clear();
          _lastErrorCircle = _circles[i];
          _currentDragPosition =
              _connectedCircles.isNotEmpty ? _connectedCircles.last : null;
        });
        return;
      }
    }

    //check if connect with next circle
    if (TmtGameCalculate.isConnectWithCircle(
        details.localPosition, _circles[_nextCircleIndex])) {
      setState(() {
        _connectedCircles.add(_circles[_nextCircleIndex]);
        _dragPath.add(_circles[_nextCircleIndex]);
        _nextCircleIndex++;
        _currentDragPosition = _circles[_nextCircleIndex - 1];
        _paths.add(List.from(_dragPath));
        _dragPath.clear();
        _dragPath.add(_currentDragPosition!);
        _lastErrorCircle = null;
      });
      return;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      if (_dragPath.isNotEmpty) {
        _dragPath.clear();
      }
      _currentDragPosition =
          _connectedCircles.isNotEmpty ? _connectedCircles.last : null;
      _lastErrorCircle = null;
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
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: TmtPainter(
                    _circles,
                    _connectedCircles,
                    _currentDragPosition,
                    _dragPath,
                    _paths,
                    _lastErrorCircle,
                    _nextCircleIndex,
                  ),
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
