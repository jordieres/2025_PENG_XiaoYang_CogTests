part of app_constants;

/// all endpoint api
class ApiPath {
  static String get _baseUrl =>
      dotenv.env['API_BASE_URL'] ?? "http://127.0.0.1";
  static String validationCode = "$_baseUrl/procesar";
  static String reportTmtResult = "$_baseUrl/reportar";
  static String listTmtMetric = "$_baseUrl/listar";
}
