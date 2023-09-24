import 'dart:convert';

class EmailVerifyRequest {
  final String email;

  EmailVerifyRequest({required this.email});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});

    return result;
  }

  factory EmailVerifyRequest.fromMap(Map<String, dynamic> map) {
    return EmailVerifyRequest(
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailVerifyRequest.fromJson(String source) =>
      EmailVerifyRequest.fromMap(json.decode(source));
}
