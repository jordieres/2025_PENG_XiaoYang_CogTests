import 'package:dio/dio.dart';

abstract class ApiError implements Exception  {
  final String message;
  final int? statusCode;
  final dynamic rawError;

  ApiError(this.message, {this.statusCode, this.rawError});

  @override
  String toString() => message;

  static ApiError create(dynamic error, {int? statusCode, String? message}) {
    final code = statusCode ?? _extractStatusCode(error);
    final msg =
        message ?? _extractErrorMessage(error) ?? 'Unknown error occurred';

    if (code == null) {
      return NetworkError(msg, rawError: error);
    }

    if (code >= 500) {
      return ServerError(msg, statusCode: code, rawError: error);
    } else if (code == 401 || code == 403) {
      return AuthenticationError(msg, statusCode: code, rawError: error);
    } else if (code >= 400 && code < 500) {
      return ClientError(msg, statusCode: code, rawError: error);
    } else {
      return UnknownApiError(msg, statusCode: code, rawError: error);
    }
  }

  static int? _extractStatusCode(dynamic error) {
    if (error == null) return null;
    if (error is Map && error['statusCode'] != null) {
      return error['statusCode'] as int;
    }
    return null;
  }

  static String? _extractErrorMessage(dynamic error) {
    if (error == null) return null;
    if (error is Map) {
      if (error['message'] != null) return error['message'] as String;
      if (error['error'] != null) return error['error'] as String;
    }

    if (error is Exception || error is Error) {
      return error.toString();
    }
    return null;
  }
}

class ServerError extends ApiError {
  ServerError(super.message, {super.statusCode, super.rawError});
}

class ClientError extends ApiError {
  ClientError(super.message, {super.statusCode, super.rawError});
}

class AuthenticationError extends ApiError {
  AuthenticationError(super.message, {super.statusCode, super.rawError});
}

class NetworkError extends ApiError {
  NetworkError(super.message, {super.rawError});
}

class UnknownApiError extends ApiError {
  UnknownApiError(super.message, {super.statusCode, super.rawError});
}


