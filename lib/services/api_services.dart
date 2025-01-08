import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../constants/api_const.dart';
import '../models/api_response.dart';

class ApiService {
  final Dio _dio = Dio();

  // Singleton pattern
  ApiService._internal() {
    _dio.options.baseUrl = ApiConst.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        responseBody: true,
      ),
    ]);
  }

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  // GET request with custom response handling
  Future<ApiResponse<T>> getRequest<T>(String endpoint) async {
    try {
      Response response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        return ApiResponse.success(response.data,
            statusCode: response.statusCode);
      } else {
        return ApiResponse.error(
          message: 'Failed to load data',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (error) {
      log("Error: $error");
      return ApiResponse.error(
        message: _handleDioError(error),
        statusCode: error.response?.statusCode,
      );
    }
  }

  // POST request with custom response handling
  Future<ApiResponse<T>> postRequest<T>(String endpoint, {dynamic data}) async {
    try {
      Response response = await _dio.post(endpoint, data: data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiResponse.success(response.data,
            statusCode: response.statusCode);
      } else {
        return ApiResponse.error(
          message: 'Failed to post data',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (error) {
      log("Error: $error");
      return ApiResponse.error(
        message: _handleDioError(error),
        statusCode: error.response?.statusCode,
      );
    }
  }

  // Handle DioError and return a user-friendly error message
  String _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return 'Connection Timeout';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return 'Receive Timeout';
    } else if (error.type == DioExceptionType.sendTimeout) {
      return 'Send Timeout';
    } else if (error.type == DioExceptionType.cancel) {
      return 'Request Cancelled';
    } else if (error.type == DioExceptionType.badResponse) {
      return _handleStatusCode(error.response?.statusCode);
    } else if (error.type == DioExceptionType.unknown) {
      return 'Unexpected error occurred';
    } else {
      return 'Unexpected error occurred';
    }
  }
}

String _handleStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request.';
    case 401:
      return 'Invalid authentication credentials.';
    case 403:
      return 'The authenticated user is not allowed to access the specified API endpoint.';
    case 404:
      return 'The requested resource does not exist.';
    case 405:
      return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
    case 415:
      return 'Unsupported media type. The requested content type or version number is invalid.';
    case 422:
      return 'Data validation failed.';
    case 429:
      return 'Too many requests.';
    case 500:
      return 'Internal server error.';
    default:
      return 'Oops something went wrong!';
  }
}
