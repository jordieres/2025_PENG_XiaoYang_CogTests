import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msdtmt/app/features/user/domain/entities/user_test_local_data_result.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../contoller/test_result_controller.dart';

class UserResultHistoryScreen extends StatefulWidget {
  const UserResultHistoryScreen({super.key});

  @override
  State<UserResultHistoryScreen> createState() =>
      _UserResultHistoryScreenState();
}

class _UserResultHistoryScreenState extends State<UserResultHistoryScreen> {
  late TestResultLocalDataController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = Get.find<TestResultLocalDataController>();
    _loadResults();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadResults() async {
    await _controller.loadCurrentUserTestResults();
  }

  DateFormat getLocalizedDateFormat() {
    final locale = Get.locale?.toString() ?? 'en_US';
    return DateFormat.yMd(locale);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceHelper.isTablet;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final double contentWidth;

    if (isLandscape) {
      contentWidth = isTablet ? screenWidth * 0.75 : screenWidth * 0.9;
    } else {
      contentWidth = isTablet ? screenWidth * 0.9 : screenWidth;
    }

    return Scaffold(
      appBar: CustomAppBar(title: UserResultHistoryScreenText.title.tr),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.testResults.isEmpty) {
          return Center(
            child: Text(
              UserResultHistoryScreenText.noData.tr,
              style: TextStyleBase.h2,
            ),
          );
        }

        return Center(
          child: SizedBox(
            width: contentWidth,
            child: _buildResultsTable(),
          ),
        );
      }),
    );
  }

  Widget _buildResultsTable() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(25),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: _buildTableHeader(),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(25),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: _buildTableBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFD1D1D1), // Light gray background for header
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              UserResultHistoryScreenText.dateHeader.tr,
              style: AppTextStyle.tmtResultHistoryTabletHeaderText,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              UserResultHistoryScreenText.referenceHeader.tr,
              style: AppTextStyle.tmtResultHistoryTabletHeaderText,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              UserResultHistoryScreenText.tmtAHeader.tr,
              style: AppTextStyle.tmtResultHistoryTabletHeaderText,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              UserResultHistoryScreenText.tmtBHeader.tr,
              style: AppTextStyle.tmtResultHistoryTabletHeaderText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBody() {
    final dateFormat = getLocalizedDateFormat();

    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _controller.testResults.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 1),
      itemBuilder: (context, index) {
        final result = _controller.testResults[index];
        return _buildResultRow(result, dateFormat);
      },
    );
  }

  Widget _buildResultRow(
      UserTestLocalDataResult result, DateFormat dateFormat) {
    final secondsUnit = UserResultHistoryScreenText.secondsUnit.tr;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              dateFormat.format(result.date),
              style: AppTextStyle.tmtResultHistoryTabletContentText,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              result.referenceCode,
              style: AppTextStyle.tmtResultHistoryTabletContentText,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${result.tmtATime.toStringAsFixed(0)}$secondsUnit',
              style: AppTextStyle.tmtResultHistoryTabletContentText,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${result.tmtBTime.toStringAsFixed(0)}$secondsUnit',
              style: AppTextStyle.tmtResultHistoryTabletContentText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
