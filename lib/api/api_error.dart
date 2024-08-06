import 'package:dio/dio.dart';

class ApiError extends DioException {
  ApiError(DioException dioError)
      : super(
          requestOptions: dioError.requestOptions,
          response: dioError.response,
          type: dioError.type,
          error: dioError.error,
        );

  @override
  String get message {
    if (response?.data.runtimeType == String) {
      return response?.data;
    }
    return response?.data['message'] ?? super.message;
  }

  int get statusCode {
    return response?.data['code'] ?? statusCode;
  }
}
