
import 'net/api_error.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestSuccess<T> extends RequestState {
  final T? data;

  RequestSuccess([this.data]);
}

class RequestError extends RequestState {
  final ApiError? error;

  RequestError(this.error);

  String? get message => error?.message;
  int? get statusCode => error?.statusCode;
  bool get isNetworkError => error is NetworkError;
  bool get isServerError => error is ServerError;
  bool get isClientError => error is ClientError;
  bool get isAuthError => error is AuthenticationError;

  factory RequestError.fromCode(String message, {int? statusCode, dynamic rawError}) {
    final apiError = ApiError.create(rawError, statusCode: statusCode, message: message);
    return RequestError(apiError);
  }

  factory RequestError.fromException(dynamic exception) {
    final apiError = ApiError.create(exception);
    return RequestError(apiError);
  }
}