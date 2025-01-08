class ApiResponse<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final bool error;

  ApiResponse({
    this.data,
    this.message,
    this.statusCode,
    required this.error,
  });

  // Factory for success response
  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse<T>(
      data: data,
      message: message ?? 'Success',
      statusCode: statusCode,
      error: false,
    );
  }

  // Factory for error response
  factory ApiResponse.error({String? message, int? statusCode}) {
    return ApiResponse<T>(
      data: null,
      message: message ?? 'An error occurred',
      statusCode: statusCode,
      error: true,
    );
  }
}
