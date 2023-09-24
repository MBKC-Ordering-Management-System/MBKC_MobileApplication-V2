import 'dart:convert';

class ChangePasswordRequest {
  final String email;
  final String newPassword;

  ChangePasswordRequest({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'newPassword': newPassword});

    return result;
  }

  factory ChangePasswordRequest.fromMap(Map<String, dynamic> map) {
    return ChangePasswordRequest(
      email: map['email'] ?? '',
      newPassword: map['newPassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordRequest.fromJson(String source) =>
      ChangePasswordRequest.fromMap(json.decode(source));
}
