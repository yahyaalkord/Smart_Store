
class ApiResponse<T>{
  final String message;
  final bool success;
  T? list;

  ApiResponse(this.message, this.success, [this.list]);
  // ApiResponse({required this.message, required this.success,required this.list});
}

class ApiResponseT<T> {
  final String message;
  final bool status;
  T? model;

  ApiResponseT({
    required this.message,
    required this.status,
    this.model,
  });
}