class ExceptionModel {
  final int statusCode;
  final String message;
  final String error;

  const ExceptionModel({
    required this.statusCode,
    required this.message,
    required this.error,
  });

  factory ExceptionModel.fromJson(Map<String, dynamic> json) {
    return ExceptionModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      error: json['error'] as String,
    );
  }
}
