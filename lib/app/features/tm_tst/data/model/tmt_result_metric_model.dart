
import 'package:intl/intl.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_result_data.dart';


class TmtResultModel extends TmtGameResultData {
  TmtResultModel({
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
    required String codeId,
    required DateTime dateData,
    required int numberErrors,
    required int numberErrorA,
    required int numberErrorB,
    required int numberLifts,
    required int numberPauses,
    required int numCirc,
    required String score,
    required double timeComplete,
    required double timeCompleteA,
    required double timeCompleteB,
    required String deviceModel,
  }) : super(
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
    codeId: codeId,
    dateData: dateData,
    numberErrors: numberErrors,
    numberErrorsA: numberErrorA,
    numberErrorsB: numberErrorB,
    numberLifts: numberLifts,
    numberPauses: numberPauses,
    numCirc: numCirc,
    score: score,
    timeComplete: timeComplete,
    timeCompleteA: timeCompleteA,
    timeCompleteB: timeCompleteB,
    deviceModel: deviceModel,
  );

  factory TmtResultModel.fromEntity(TmtGameResultData entity) {
    return TmtResultModel(
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
      codeId: entity.codeId,
      dateData: entity.dateData,
      numberErrors: entity.numberErrors,
      numberErrorA: entity.numberErrorsA,
      numberErrorB: entity.numberErrorsB,
      numberLifts: entity.numberLifts,
      numberPauses: entity.numberPauses,
      numCirc: entity.numCirc,
      score: entity.score,
      timeComplete: entity.timeComplete,
      timeCompleteA: entity.timeCompleteA,
      timeCompleteB: entity.timeCompleteB,
      deviceModel: entity.deviceModel,
    );
  }

  Map<String, dynamic> toJson() {
    final formatter = DateFormat('EEE, dd MMM yyyy HH:mm:ss', 'en_US');
    final utcDate = dateData.toUtc();
    final formattedDate = '${formatter.format(utcDate)} GMT';

    return {
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
      'Score': score,
      'Number_Errors_A': numberErrorsA,
      'Number_Errors_B': numberErrorsB,
      'Time_Complete_A': timeCompleteA,
      'Time_Complete_B': timeCompleteB,
      'Device_Model': deviceModel,
    };
  }

}