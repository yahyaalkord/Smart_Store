class ApiResponse<T>{
  final String message;
  final bool success;
  T? list;

  ApiResponse(this.message, this.success, [this.list]);
}