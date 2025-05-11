part of 'rest_api_services.dart';

class ApiConstants {
  static const String validateReferenceCodeTag = "validateReferenceCode";
  static const String reportTmtResultsTag = "reportTmtResults";
  static const String listTestResultsTag = "listTestResults";

  static const String messageField = "message";
  static const String statusField = "status";
  static const String dataField = "data";
  static const String statusOk = "OK";
  static const String statusError = "error";
  static const String codeIdField = "codeid";
  static const String dateDataField = "date_data";

  static const String referenceCodeValid = "OK";
  static const String referenceCodeInvalid = "Nok";
  static const String referenceCodeNumberExists = "exists";
  static const String referenceCodeHandsUsed = "hands";
  static const String referenceCodeHandLeft = "I";
  static const String referenceCodeHandRight = "D";
}
