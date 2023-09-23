import 'dart:convert';

class ErrorDetailModel {
  final String fieldNameError;
  final List<String> descriptionError;

  ErrorDetailModel({
    required this.fieldNameError,
    required this.descriptionError,
  });

  factory ErrorDetailModel.fromMap(Map<String, dynamic> map) {
    return ErrorDetailModel(
      fieldNameError: map['FieldNameError'] ?? '',
      descriptionError: List<String>.from(map['DescriptionError']),
    );
  }

  factory ErrorDetailModel.fromJson(String source) =>
      ErrorDetailModel.fromMap(json.decode(source));
}
