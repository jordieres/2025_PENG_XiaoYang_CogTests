import 'package:flutter/material.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_painter.dart';

import '../../../../utils/helpers/app_helpers.dart';
import '../../data/datasources/generate_circle_with_data.dart';
import '../../data/datasources/random_grid_sampler.dart';
import '../../domain/entities/metric/tmt_metrics_controller.dart';
import '../../domain/entities/tmt_game_circle.dart';
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
  final TmtMetricsController _metricsController = TmtMetricsController();

  late List<TmtGameCircle> _circles = [];
  final List<TmtGameCircle> _connectedCircles = [];
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
  TmtGameCircle? _errorCircle;
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
    //TODO modificar segun tipo de juego
    _metricsController.onTestStart(TmtGameTypeMetrics.typeA);
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
    _errorPath.clear(); // Clear error path
    _errorCircle = null;
    _isDragging = false;
    _hasError = false; // Reset error state

    final listCirclesOffset = RandomGridSampler(
            minDistance: TmtGameVariables.safeDistance,
            minX: TmtGameCalculate.getBoardMinX(),
            maxX: TmtGameCalculate.getBoardMaxX(_constraintsMaxWidth),
            minY: TmtGameCalculate.getBoardMinY(),
            maxY: TmtGameCalculate.getBoardMaxY(_constraintsMaxHeight))
        .generatePoints(
      TmtGameVariables.CIRCLE_NUMBER,
    );

    _circles = GenerateCircleWithData(
            tmtGameCircleTextType: TmtGameCircleTextType.NUMBER)
        .generateCircle(listCirclesOffset);
  }

  void _onPanStart(DragStartDetails details) {
    // Don't allow new drag when in error state
    if (_hasError) return;

    //Set First circle as starting point
    if (_nextCircleIndex == 0) {
      if (TmtGameCalculate.isConnectWithCircle(
          details.localPosition, _circles[0].offset)) {
        setState(() {
          _isDragging = true;
          _connectedCircles.add(_circles[0]);
          _nextCircleIndex = 1;
          _currentDragPosition = _circles[0].offset;
          _dragPath.clear();
          _dragPath.add(_circles[0].offset);
          _errorCircle = null;
        });
      }
    }
    //Avoid the start point of drag is other circle
    // It must to be last connected circle
    else if (_nextCircleIndex < TmtGameVariables.CIRCLE_NUMBER) {
      if (TmtGameCalculate.isConnectWithCircle(
          details.localPosition, _connectedCircles.last.offset)) {
        setState(() {
          _isDragging = true;
          _currentDragPosition = _connectedCircles.last.offset;
          _dragPath.clear();
          _dragPath.add(_connectedCircles.last.offset);
          _errorCircle = null;
        });
      }
    }
    _metricsController.onPanStart(details);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _metricsController.onPanUpdate(details);
    if (!_isDragging || _hasError) return;

    setState(() {
      _currentDragPosition = details.localPosition;
      _dragPath.add(details.localPosition);
    });

    if (_nextCircleIndex >= TmtGameVariables.CIRCLE_NUMBER) {
      _showCompletionDialog();
      return;
    }

    for (int i = 0; i < _circles.length; i++) {
      final currentCircle = _circles[i];

      if (i == _nextCircleIndex || _connectedCircles.contains(currentCircle)) {
        continue;
      }

      if (TmtGameCalculate.isConnectWithCircle(
          details.localPosition, currentCircle.offset)) {
        _connectOtherIncorrectCircleConfig(currentCircle);
        return;
      }
    }

    if (TmtGameCalculate.isConnectWithCircle(
        details.localPosition, _circles[_nextCircleIndex].offset)) {
      _connectNextCorrectCircleConfig(details.localPosition);
      return;
    }
  }

  _connectOtherIncorrectCircleConfig(TmtGameCircle currentCircle) {
    _metricsController.onConnectNextCircleError();
    setState(() {
      _isDragging = false;
      _dragPath.add(currentCircle.offset);
      _errorPath = List.from(_dragPath); // Save the current path as error path
      _dragPath.clear();
      _currentDragPosition =
          _connectedCircles.isNotEmpty ? _connectedCircles.last.offset : null;
    });
    _showErrorStatus(currentCircle);
  }

  void _showErrorStatus(TmtGameCircle errorOffset) {
    setState(() {
      _errorCircle = errorOffset;
      _hasError = true;
      _lasTimeHasError = true;
    });

    Future.delayed(
        Duration(milliseconds: TmtGameVariables.ERROR_CIRLCLE_APPEAR_DURATION),
        () {
      if (mounted) {
        setState(() {
          _errorCircle = null;
          _errorPath = []; // Clear error path after 1 second
          _hasError = false;
        });
      }
    });
  }

  _connectNextCorrectCircleConfig(Offset currentDragPosition) {
    setState(() {
      final nextCircle = _circles[_nextCircleIndex];
      _connectedCircles.add(nextCircle);

      //Add the TOUCH_MARGIN to the last point of the path
      _dragPath.add(TmtGameCalculate.closestPointOnCircle(
          nextCircle.offset, TmtGameVariables.circleRadius, _dragPath.last));

      _paths.add(List.from(_dragPath));
      _currentDragPosition = currentDragPosition;

      _dragPath.clear();
      _dragPath.add(currentDragPosition);
      _errorCircle = null;
      _lasTimeHasError = false;
      _nextCircleIndex++;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Don't clear paths if there's an error (let the timer handle it)
    if (_hasError) return;

    setState(() {
      // Show current circle when finger up
      if (_connectedCircles.isNotEmpty) {
        _lasTimeHasError = true;
      }
      _isDragging = false;
      if (_dragPath.isNotEmpty) {
        _dragPath.clear();
      }
      _currentDragPosition =
          _connectedCircles.isNotEmpty ? _connectedCircles.last.offset : null;
    });

    _metricsController.onPanEnd(details);
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
    DeviceHelper.init(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (_constraintsMaxWidth != constraints.maxWidth ||
            _constraintsMaxHeight != constraints.maxHeight) {
          _constraintsMaxWidth = constraints.maxWidth;
          _constraintsMaxHeight = constraints.maxHeight;

          TmtGameVariables.calculateTMTGameVariables(
              _constraintsMaxWidth, _constraintsMaxHeight);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _generateRandomCircle();
            });
          });
        }
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: TmtPainter(
                        allCircles: _circles,
                        connectedCircles: _connectedCircles,
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
                ),
              ],
            ),
            Positioned.fill(
              child: Listener(
                onPointerMove: (PointerMoveEvent event) {
                  setState(() {
                    _metricsController.onPointerMove(event);
                    // print('PointerMoveEvent pressure: ${event.pressure}');
                    // print('PointerMoveEvent size: ${event.size}');
                  });
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),
          ],
        );
      },
    );
  }
}
