class ApiErrorModel {
  final bool? status;
  final String? message;

  ApiErrorModel({this.status, this.message});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
