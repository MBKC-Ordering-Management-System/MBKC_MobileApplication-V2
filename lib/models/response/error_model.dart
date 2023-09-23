import 'dart:convert';
import 'error_detail_model.dart';

class ErrorModel {
  final int statusCode;
  final List<ErrorDetailModel> message;

  ErrorModel({
    required this.statusCode,
    required this.message,
  });

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      statusCode: map['StatusCode']?.toInt() ?? 0,
      message: List<ErrorDetailModel>.from(
          map['Message']?.map((x) => ErrorDetailModel.fromMap(x))),
    );
  }

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));
}
