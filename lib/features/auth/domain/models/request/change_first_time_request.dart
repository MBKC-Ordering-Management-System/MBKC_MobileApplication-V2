import 'dart:convert';

class ChangeFirstTimeRequest {
  final String newPassword;

  ChangeFirstTimeRequest({required this.newPassword});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'newPassword': newPassword});

    return result;
  }

  factory ChangeFirstTimeRequest.fromMap(Map<String, dynamic> map) {
    return ChangeFirstTimeRequest(
      newPassword: map['newPassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeFirstTimeRequest.fromJson(String source) =>
      ChangeFirstTimeRequest.fromMap(json.decode(source));
}
