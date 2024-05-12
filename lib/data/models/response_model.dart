class ResponseModel<T> {
  String errorMessage;
  T? data;
  bool hasError;
  ResponseModel({
    this.errorMessage = '',
    this.data,
    this.hasError = false,
  });
}
