import 'dart:convert';
import '../../../../../utils/enums/enums_export.dart';

class PartnerRequest {
  final String username;
  final String password;
  final PartnerType type;

  PartnerRequest({
    required this.username,
    required this.password,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'type': type.type});

    return result;
  }

  factory PartnerRequest.fromMap(Map<String, dynamic> map) {
    return PartnerRequest(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      type: (map['type'] as int).toPartnerTypeEnum(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PartnerRequest.fromJson(String source) =>
      PartnerRequest.fromMap(json.decode(source));
}
