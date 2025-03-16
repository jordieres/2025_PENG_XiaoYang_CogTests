import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/controllers/tmt_test_flow_state_controller.dart';
import '../../../../config/routes/app_pages.dart';

class TmtResultsScreen extends StatelessWidget {
  const TmtResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TmtTestFlowStateController testController = Get.find<TmtTestFlowStateController>();
    final metrics = testController.metricsController;

    final partADuration = metrics.testTimeMetrics.calculateTimeCompleteTmtA();
    final partBDuration = metrics.testTimeMetrics.calculateTimeCompleteTmtB();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TMT Test Results'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
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
                'Duration: $partADuration seconds',
                'Errors: ${metrics.numberError}',
              ),
              const SizedBox(height: 16),
              _buildResultCard(
                'Part B',
                'Duration: $partBDuration seconds',
                'Errors: ${metrics.numberError}',
              ),
              const SizedBox(height: 32),
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
