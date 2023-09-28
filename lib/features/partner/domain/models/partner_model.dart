import 'dart:convert';
import '../../../../utils/enums/enums_export.dart';

class PartnerModel {
  final int id;
  final String username;
  final String password;
  final PartnerType type;

  PartnerModel({
    required this.id,
    required this.username,
    required this.password,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'type': type.type});

    return result;
  }

  factory PartnerModel.fromMap(Map<String, dynamic> map) {
    return PartnerModel(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      type: (map['type'] as int).toPartnerTypeEnum(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PartnerModel.fromJson(String source) =>
      PartnerModel.fromMap(json.decode(source));
}
