import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_result_data.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/controllers/tmt_test_flow_state_controller.dart';
import '../../../../config/routes/app_pages.dart';

class TmtResultsScreen extends StatelessWidget {
  const TmtResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TmtTestFlowStateController testController =
    Get.find<TmtTestFlowStateController>();

    final Future<TmtGameResultData> resultFuture = TmtGameResultData.fromMetricsController(
        testController.metricsController, context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TMT Test Results'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<TmtGameResultData>(
        future: resultFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading results: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No test data available'),
            );
          }

          final result = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Test Completed',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildResultCard(
                    'Part A',
                    'Duration: ${result.timeCompleteA} seconds',
                    'Errors: ${result.numberErrorA}',
                  ),
                  const SizedBox(height: 16),
                  _buildResultCard(
                    'Part B',
                    'Duration: ${result.timeCompleteB} seconds',
                    'Errors: ${result.numberErrorB}',
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Device: ${result.deviceModel}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('Detailed Test Metrics',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Time: ${result.timeComplete.toStringAsFixed(2)} seconds'),
                            Text('Total Errors: ${result.numberErrors}'),
                            const Divider(),
                            Text('Average Lift: ${result.averageLift.toStringAsFixed(2)} ms'),
                            Text('Average Pause: ${result.averagePause.toStringAsFixed(2)} ms'),
                            Text('Number of Lifts: ${result.numberLifts}'),
                            Text('Number of Pauses: ${result.numberPauses}'),
                            const Divider(),
                            Text('Average Rate Between Circles: ${result.averageRateBetweenCircles.toStringAsFixed(2)}'),
                            Text('Average Rate Inside Circles: ${result.averageRateInsideCircles.toStringAsFixed(2)}'),
                            Text('Average Time Between Circles: ${result.averageTimeBetweenCircles.toStringAsFixed(2)} seconds'),
                            Text('Average Time Inside Circles: ${result.averageTimeInsideCircles.toStringAsFixed(2)} seconds'),
                            const Divider(),
                            Text('Average Rate Before Letters: ${result.averageRateBeforeLetters.toStringAsFixed(2)}'),
                            Text('Average Rate Before Numbers: ${result.averageRateBeforeNumbers.toStringAsFixed(2)}'),
                            Text('Average Time Before Letters: ${result.averageTimeBeforeLetters.toStringAsFixed(2)} seconds'),
                            Text('Average Time Before Numbers: ${result.averageTimeBeforeNumbers.toStringAsFixed(2)} seconds'),
                            const Divider(),
                            Text('Average Total Pressure: ${result.averageTotalPressure.toStringAsFixed(2)}'),
                            Text('Average Total Size: ${result.averageTotalSize.toStringAsFixed(2)}'),
                            const Divider(),
                            Text('Number of Circles: ${result.numCirc}'),
                            Text('Date: ${result.dateData.toString()}'),
                            if (result.codeId.isNotEmpty) Text('Code ID: ${result.codeId}'),
                            if (result.score.isNotEmpty) Text('Score: ${result.score}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Thank you for completing the test!',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.home);
                    },
                    child: const Text('Return to Home'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultCard(String title, String duration, String errors) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(duration),
            const SizedBox(height: 8),
            Text(errors),
          ],
        ),
      ),
    );
  }
}