import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_painter.dart';

import '../../../../utils/helpers/app_helpers.dart';
import '../../data/datasources/generate_circle_with_data.dart';
import '../../data/datasources/random_grid_sampler.dart';
import '../../domain/entities/metric/tmt_metrics_controller.dart';
import '../../domain/entities/tmt_game/tmt_game_circle.dart';
import '../../domain/usecases/tmt_game_calculate.dart';
import '../../domain/entities/tmt_game/tmt_game_variable.dart';
import '../controllers/base_tmt_test_flow_contoller.dart';

/// This class manages logic of tmt test
class TmtGameBoardController extends StatefulWidget {
  // Add a parameter to accept the controller directly
  final BaseTmtTestFlowController? flowController;

  TmtGameBoardController({super.key, this.flowController});

  late final _TmtGameBoardControllerState _state =
      _TmtGameBoardControllerState();

  void regenerateCircles() {
    _state.regenerateCircles();
  }

  void toggleCheatMode() {
    _state.toggleCheatMode();
  }

  bool get isCheatModeEnabled => _state.isCheatModeEnabled;

  @override
  _TmtGameBoardControllerState createState() => _state;
}

class _TmtGameBoardControllerState extends State<TmtGameBoardController> {
  late BaseTmtTestFlowController _testFlowController;
  late TmtMetricsController _metricsController;
  Worker? _configWorker;

  late TmtGameCircleTextType _circleTextType;

  List<TmtGameCircle> _circles = [];
  final List<TmtGameCircle> _connectedCircles = [];
  Offset? _currentDragPosition;
  int _nextCircleIndex = 0;
  final List<Offset> _dragPath = [];
  final List<List<Offset>> _paths = [];
  List<Offset> _errorPath = []; // Added to store error path
  bool _hasError = false; // Track error state
  bool _lasTimeHasError = false;
  bool _isLoading = true;

  // Add cheat mode boolean
  bool _isCheatModeEnabled = false;

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
    // Use the provided controller if available, otherwise find one
    _testFlowController =
        widget.flowController ?? Get.find<BaseTmtTestFlowController>();
    _metricsController = _testFlowController.getMetricsController();

    // Set the circle text type based on test type
    if (_testFlowController.testState.value ==
            TmtTestStateFlow.TMT_A_IN_PROGRESS ||
        _testFlowController.testState.value == TmtTestStateFlow.READY) {
      _circleTextType = TmtGameCircleTextType.NUMBER;
    } else {
      _circleTextType = TmtGameCircleTextType.NUMBER_WITH_LETTER;
    }

    setState(() {
      _isLoading = true;
    });

    _configWorker = ever(_testFlowController.isConfigLoaded, (isLoaded) {
      if (isLoaded) {
        _testFlowController.startTest();

        if (_constraintsMaxWidth > 0 && _constraintsMaxHeight > 0) {
          _generateRandomCircle();
        }
      }
    });

    if (_testFlowController.isConfigLoaded.value) {
      _testFlowController.startTest();
    }
  }

  @override
  void dispose() {
    _configWorker?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _generateRandomCircle() {
    setState(() {
      _isLoading = false;

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

      _circles = GenerateCircleWithData(tmtGameCircleTextType: _circleTextType)
          .generateCircle(listCirclesOffset);

      _metricsController.circles = _circles;
    });
  }

  void _onPanStart(DragStartDetails details) {
    if (_hasError || _isLoading) return;

    //Set First circle as starting point
    if (_nextCircleIndex == 0) {
      if (TmtGameCalculate.isConnectWithCircle(
          details.localPosition, _circles[0].offset)) {
        setState(() {
          _isDragging = true;
          _connectedCircles.add(_circles[0]);
          _metricsController.onConnectNextCircleCorrect(_nextCircleIndex,
              _circles[0], _testFlowController.getTmtTestNavigationFlow());
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
    _metricsController.onPanUpdate(details, _connectedCircles);
    if (!_isDragging || _hasError || _isLoading) return;

    setState(() {
      _currentDragPosition = details.localPosition;
      _dragPath.add(details.localPosition);
    });

    if (_nextCircleIndex >= TmtGameVariables.CIRCLE_NUMBER) {
      _onCompleteTest();
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
    _metricsController.onConnectNextCircleError(
        _testFlowController.getTmtTestNavigationFlow());
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

      _metricsController.onConnectNextCircleCorrect(_nextCircleIndex,
          nextCircle, _testFlowController.getTmtTestNavigationFlow());

      _dragPath.clear();
      _dragPath.add(currentDragPosition);
      _errorCircle = null;
      _lasTimeHasError = false;
      _nextCircleIndex++;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Don't clear paths if there's an error (let the timer handle it)
    if (_hasError || _isLoading) return;

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

  void _onCompleteTest() {
    if (_connectedCircles.isNotEmpty) {
      _testFlowController.onTestEnd(_connectedCircles.last.offset);
    }
  }

  void regenerateCircles() {
    if (_testFlowController.isConfigLoaded.value) {
      _generateRandomCircle();
    }
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

          if (_testFlowController.isConfigLoaded.value) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _generateRandomCircle();
            });
          }
        }

        if (_isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
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
