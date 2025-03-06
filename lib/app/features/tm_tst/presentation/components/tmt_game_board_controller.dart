import 'package:flutter/material.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_painter.dart';

import '../../data/datasources/random_grid_sampler.dart';
import '../../domain/usecases/tmt_game_calculate.dart';
import '../../domain/entities/tmt_game_variable.dart';

/// This class manager logic of tmt test
class TmtGameBoardController extends StatefulWidget {
  TmtGameBoardController({super.key});

  final _TmtGameBoardControllerState _state = _TmtGameBoardControllerState();

  void regenerateCircles() {
    _state.regenerateCircles();
  }

  // Add method to toggle cheat mode
  void toggleCheatMode() {
    _state.toggleCheatMode();
  }

  // Add getter to check if cheat mode is enabled
  bool get isCheatModeEnabled => _state.isCheatModeEnabled;

  @override
  _TmtGameBoardControllerState createState() => _state;
}

class _TmtGameBoardControllerState extends State<TmtGameBoardController> {
  late List<Offset> _circles = [];
  final List<Offset> _connectedCircles = [];
  Offset? _currentDragPosition;
  int _nextCircleIndex = 0;
  final List<Offset> _dragPath = [];
  final List<List<Offset>> _paths = [];
  List<Offset> _errorPath = []; // Added to store error path
  bool _hasError = false; // Track error state
  bool _lasTimeHasError = false;

  // Add cheat mode boolean
  bool _isCheatModeEnabled = true;

  double _constraintsMaxWidth = 0;
  double _constraintsMaxHeight = 0;
  Offset? _errorCircle;
  bool _isDragging = false;

  // Getter for cheat mode
  bool get isCheatModeEnabled => _isCheatModeEnabled;

  // Toggle cheat mode method
  void toggleCheatMode() {
    setState(() {
      _isCheatModeEnabled = !_isCheatModeEnabled;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void showError(Offset errorPosition) {
    setState(() {
      _errorCircle = errorPosition;
      _hasError = true;
      _lasTimeHasError = true;
    });

    // 1秒后自动清除错误状态
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _errorCircle = null;
          _errorPath = []; // Clear error path after 1 second
          _hasError = false;
        });
      }
    });
  }

  _generateRandomCircle() {
    _circles.clear();
    _connectedCircles.clear();
    _nextCircleIndex = 0;
    _paths.clear();
    _dragPath.clear();
    _errorPath.clear(); // Clear error path
    _errorCircle = null;
    _isDragging = false;
    _hasError = false; // Reset error state

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
    // Don't allow new drag when in error state
    if (_hasError) return;

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
          // 清除之前可能存在的错误状态
          _errorCircle = null;
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
          // 清除之前可能存在的错误状态
          _errorCircle = null;
        });
      }
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging || _hasError) return;

    setState(() {
      _currentDragPosition = details.localPosition;
      _dragPath.add(details.localPosition);
      print(details.toString());
    });

    if (_nextCircleIndex >= TmtGameVariables.CIRCLE_NUMBER) {
      _showCompletionDialog();
      return;
    }

    // 检查是否连接到了错误的圆圈
    for (int i = 0; i < _circles.length; i++) {
      if (i == _nextCircleIndex || _connectedCircles.contains(_circles[i])) {
        continue;
      }

      if (TmtGameCalculate.isConnectWithCircle(
          details.localPosition, _circles[i])) {
        setState(() {
          _isDragging = false;
          _dragPath.add(_circles[i]);
          _errorPath =
              List.from(_dragPath); // Save the current path as error path
          _dragPath.clear();
          _currentDragPosition =
              _connectedCircles.isNotEmpty ? _connectedCircles.last : null;
        });

        showError(_circles[i]);
        return;
      }
    }

    if (TmtGameCalculate.isConnectWithCircle(
        details.localPosition, _circles[_nextCircleIndex])) {
      setState(() {
        _connectedCircles.add(_circles[_nextCircleIndex]);
        _dragPath.add(_circles[_nextCircleIndex]);
        _paths.add(List.from(_dragPath));
        _nextCircleIndex++;
        _currentDragPosition = _circles[_nextCircleIndex - 1];
        _dragPath.clear();
        _dragPath.add(_currentDragPosition!);
        _errorCircle = null;
        _lasTimeHasError = false;
      });
      return;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    // Don't clear paths if there's an error (let the timer handle it)
    if (_hasError) return;

    setState(() {
      _isDragging = false;
      if (_dragPath.isNotEmpty) {
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
                regenerateCircles();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void regenerateCircles() {
    setState(() {
      _generateRandomCircle();
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
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: TmtPainter(
                    allPoints: _circles,
                    connectedPoints: _connectedCircles,
                    currentDragPosition: _currentDragPosition,
                    dragPath: _dragPath,
                    paths: _paths,
                    errorCircle: _errorCircle,
                    nextCircleIndex: _nextCircleIndex,
                    errorPath: _errorPath,
                    hasError: _hasError,
                    lasTimeHasError: _lasTimeHasError,
                    isCheatModeEnabled: _isCheatModeEnabled,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
