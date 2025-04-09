import 'package:intl/intl.dart';

import '../../../../constans/send_tmt_result_date_formatter.dart';
import '../../domain/entities/metric/metric_static_values.dart';
import '../../domain/entities/result/tmt_game_init_data.dart';
import '../../domain/entities/result/tmt_game_result_data.dart';
import '../../domain/entities/tmt_game/tmt_game_variable.dart';

class TmtResultModel {
  final TmtGameInitData tmtGameInitData;
  final double averageLift;
  final double averagePause;
  final double averageRateBeforeLetters;
  final double averageRateBeforeNumbers;
  final double averageRateBetweenCircles;
  final double averageRateInsideCircles;
  final double averageTimeBeforeLetters;
  final double averageTimeBeforeNumbers;
  final double averageTimeBetweenCircles;
  final double averageTimeInsideCircles;
  final double averageTotalPressure;
  final double averageTotalSize;
  final String dateData;
  final int numberErrors;
  final int numberErrorsA;
  final int numberErrorsB;
  final int numberLifts;
  final int numberPauses;
  final int numCirc;
  final double timeComplete;
  final double timeCompleteA;
  final double timeCompleteB;
  final String deviceModel;
  final double scoreA;
  final double scoreA1;
  final double scoreA2;
  final double scoreA3;
  final double scoreA4;
  final double scoreA5;
  final double scoreB;
  final double scoreB1;
  final double scoreB2;
  final double scoreB3;
  final double scoreB4;
  final double scoreB5;

  TmtResultModel({
    required this.tmtGameInitData,
    required this.averageLift,
    required this.averagePause,
    required this.averageRateBeforeLetters,
    required this.averageRateBeforeNumbers,
    required this.averageRateBetweenCircles,
    required this.averageRateInsideCircles,
    required this.averageTimeBeforeLetters,
    required this.averageTimeBeforeNumbers,
    required this.averageTimeBetweenCircles,
    required this.averageTimeInsideCircles,
    required this.averageTotalPressure,
    required this.averageTotalSize,
    required this.dateData,
    required this.numberErrors,
    required this.numberErrorsA,
    required this.numberErrorsB,
    required this.numberLifts,
    required this.numberPauses,
    required this.numCirc,
    required this.timeComplete,
    required this.timeCompleteA,
    required this.timeCompleteB,
    required this.deviceModel,
    required this.scoreA,
    required this.scoreA1,
    required this.scoreA2,
    required this.scoreA3,
    required this.scoreA4,
    required this.scoreA5,
    required this.scoreB,
    required this.scoreB1,
    required this.scoreB2,
    required this.scoreB3,
    required this.scoreB4,
    required this.scoreB5,
  });

  factory TmtResultModel.fromEntity(TmtGameResultData entity) {
    final formatter = DateFormat(
        SendTMTResultDateFormatter.TMT_TEST_RESULT_SEND_DATA_FORMATTER,
        SendTMTResultDateFormatter.DATE_LOCALE);
    final utcDate = entity.dateData.toUtc();
    final formattedDate = formatter.format(utcDate);

    return TmtResultModel(
      tmtGameInitData: entity.tmtGameInitData,
      averageLift: entity.averageLift,
      averagePause: entity.averagePause,
      averageRateBeforeLetters: entity.averageRateBeforeLetters,
      averageRateBeforeNumbers: entity.averageRateBeforeNumbers,
      averageRateBetweenCircles: entity.averageRateBetweenCircles,
      averageRateInsideCircles: entity.averageRateInsideCircles,
      averageTimeBeforeLetters: entity.averageTimeBeforeLetters,
      averageTimeBeforeNumbers: entity.averageTimeBeforeNumbers,
      averageTimeBetweenCircles: entity.averageTimeBetweenCircles,
      averageTimeInsideCircles: entity.averageTimeInsideCircles,
      averageTotalPressure: entity.averageTotalPressure,
      averageTotalSize: entity.averageTotalSize,
      dateData: formattedDate,
      numberErrors: entity.numberErrors,
      numberErrorsA: entity.numberErrorsA,
      numberErrorsB: entity.numberErrorsB,
      numberLifts: entity.numberLifts,
      numberPauses: entity.numberPauses,
      numCirc: entity.numCirc,
      timeComplete: entity.timeComplete,
      timeCompleteA: entity.timeCompleteA,
      timeCompleteB: entity.timeCompleteB,
      deviceModel: entity.deviceModel,
      scoreA: entity.timeCompleteA,
      scoreA1: entity.scoreA1,
      scoreA2: entity.scoreA2,
      scoreA3: entity.scoreA3,
      scoreA4: entity.scoreA4,
      scoreA5: entity.scoreA5,
      scoreB: entity.timeCompleteB,
      scoreB1: entity.scoreB1,
      scoreB2: entity.scoreB2,
      scoreB3: entity.scoreB3,
      scoreB4: entity.scoreB4,
      scoreB5: entity.scoreB5,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {
      'codeid': tmtGameInitData.tmtGameCodeId,
      "Mano": tmtGameInitData.tmtGameHandUsed.value,
      'NumCirc': numCirc,
      'Time_complete': timeComplete,
      'Number_Errors': numberErrors,
      'Average_Pause': averagePause,
      'Average_Lift': averageLift,
      'Average_Rate_Between_Circles': averageRateBetweenCircles,
      'Average_Rate_Inside_Circles': averageRateInsideCircles,
      'Average_Time_Between_Circles': averageTimeBetweenCircles,
      'Average_Time_Inside_Circles': averageTimeInsideCircles,
      'Average_Rate_Before_Letters': averageRateBeforeLetters,
      'Average_Rate_Before_Numbers': averageRateBeforeNumbers,
      'Average_Time_Before_Letters': averageTimeBeforeLetters,
      'Average_Time_Before_Numbers': averageTimeBeforeNumbers,
      'Number_Pauses': numberPauses,
      'Number_Lifts': numberLifts,
      'Average_Total_Pressure': averageTotalPressure,
      'Average_Total_Size': averageTotalSize,
      'Date_Data': dateData,
      'Number_Errors_A': numberErrorsA,
      'Number_Errors_B': numberErrorsB,
      'Time_Complete_A': timeCompleteA,
      'Time_Complete_B': timeCompleteB,
      'Device': deviceModel,
      'ScoreA': scoreA,
      'ScoreA1': scoreA1,
      'ScoreA2': scoreA2,
      'ScoreA3': scoreA3,
      'ScoreB': scoreB,
      'ScoreB1': scoreB1,
      'ScoreB2': scoreB2,
      'ScoreB3': scoreB3,
    };

    /// Only have score 4 and 5 if number circles is 25
    void addScoreIfValid(String key, double value, Map<String, dynamic> data) {
      if (value != MetricStaticValues.NOT_SECTION_4_AND_5 ||
          TmtGameVariables.CIRCLE_NUMBER ==
              TmtGameVariables.DEFAULT_CIRCLE_NUMBER) {
        data[key] = value;
      }
    }

    addScoreIfValid('ScoreA4', scoreA4, result);
    addScoreIfValid('ScoreA5', scoreA5, result);
    addScoreIfValid('ScoreB4', scoreB4, result);
    addScoreIfValid('ScoreB5', scoreB5, result);

    return result;
  }
}
