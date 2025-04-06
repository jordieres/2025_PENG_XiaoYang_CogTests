import 'package:intl/intl.dart';

import '../../domain/entities/metric/metric_static_values.dart';
import '../../domain/entities/result/tmt_game_init_data.dart';
import '../../domain/entities/result/tmt_game_result_data.dart';
import '../../domain/entities/tmt_game/tmt_game_variable.dart';

class TmtResultModel extends TmtGameResultData {
  TmtResultModel({
    required TmtGameInitData tmtGameInitData,
    required double averageLift,
    required double averagePause,
    required double averageRateBeforeLetters,
    required double averageRateBeforeNumbers,
    required double averageRateBetweenCircles,
    required double averageRateInsideCircles,
    required double averageTimeBeforeLetters,
    required double averageTimeBeforeNumbers,
    required double averageTimeBetweenCircles,
    required double averageTimeInsideCircles,
    required double averageTotalPressure,
    required double averageTotalSize,
    required DateTime dateData,
    required int numberErrors,
    required int numberErrorA,
    required int numberErrorB,
    required int numberLifts,
    required int numberPauses,
    required int numCirc,
    required double timeComplete,
    required double timeCompleteA,
    required double timeCompleteB,
    required String deviceModel,
    required double scoreA,
    required double scoreA1,
    required double scoreA2,
    required double scoreA3,
    required double scoreA4,
    required double scoreA5,
    required double scoreB,
    required double scoreB1,
    required double scoreB2,
    required double scoreB3,
    required double scoreB4,
    required double scoreB5,
  }) : super(
          tmtGameInitData: tmtGameInitData,
          averageLift: averageLift,
          averagePause: averagePause,
          averageRateBeforeLetters: averageRateBeforeLetters,
          averageRateBeforeNumbers: averageRateBeforeNumbers,
          averageRateBetweenCircles: averageRateBetweenCircles,
          averageRateInsideCircles: averageRateInsideCircles,
          averageTimeBeforeLetters: averageTimeBeforeLetters,
          averageTimeBeforeNumbers: averageTimeBeforeNumbers,
          averageTimeBetweenCircles: averageTimeBetweenCircles,
          averageTimeInsideCircles: averageTimeInsideCircles,
          averageTotalPressure: averageTotalPressure,
          averageTotalSize: averageTotalSize,
          dateData: dateData,
          numberErrors: numberErrors,
          numberErrorsA: numberErrorA,
          numberErrorsB: numberErrorB,
          numberLifts: numberLifts,
          numberPauses: numberPauses,
          numCirc: numCirc,
          timeComplete: timeComplete,
          timeCompleteA: timeCompleteA,
          timeCompleteB: timeCompleteB,
          deviceModel: deviceModel,
          scoreA: scoreA,
          scoreA1: scoreA1,
          scoreA2: scoreA2,
          scoreA3: scoreA3,
          scoreA4: scoreA4,
          scoreA5: scoreA5,
          scoreB: scoreB,
          scoreB1: scoreB1,
          scoreB2: scoreB2,
          scoreB3: scoreB3,
          scoreB4: scoreB4,
          scoreB5: scoreB5,
        );

  factory TmtResultModel.fromEntity(TmtGameResultData entity) {
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
      dateData: entity.dateData,
      numberErrors: entity.numberErrors,
      numberErrorA: entity.numberErrorsA,
      numberErrorB: entity.numberErrorsB,
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
    final formatter = DateFormat('EEE, dd MMM yyyy HH:mm:ss', 'en_US');
    final utcDate = dateData.toUtc();
    final formattedDate = '${formatter.format(utcDate)} GMT';

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
      'Date_Data': formattedDate,
      'Number_Errors_A': numberErrorsA,
      'Number_Errors_B': numberErrorsB,
      'Time_Complete_A': timeCompleteA,
      'Time_Complete_B': timeCompleteB,
      'Device': deviceModel,
      // Section scores
      'ScoreA': scoreA,
      'ScoreA1': scoreA1,
      'ScoreA2': scoreA2,
      'ScoreA3': scoreA3,
      'ScoreB': scoreB,
      'ScoreB1': scoreB1,
      'ScoreB2': scoreB2,
      'ScoreB3': scoreB3,
    };

    addScoreIfValid('ScoreA4', scoreA4, result);
    addScoreIfValid('ScoreA5', scoreA5, result);
    addScoreIfValid('ScoreB4', scoreB4, result);
    addScoreIfValid('ScoreB5', scoreB5, result);

    return result;
  }

  /// Only have score 4 and 5 if number circles is 25
  void addScoreIfValid(String key, double value, Map<String, dynamic> result) {
    if (value != MetricStaticValues.NOT_SECTION_4_AND_5 ||
        TmtGameVariables.CIRCLE_NUMBER ==
            TmtGameVariables.DEFAULT_CIRCLE_NUMBER) {
      result[key] = value;
    }
  }
}
