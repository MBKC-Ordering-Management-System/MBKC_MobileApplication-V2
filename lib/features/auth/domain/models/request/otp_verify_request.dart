import 'dart:convert';

class OTPVerifyRequest {
  final String email;
  final String otpcode;

  OTPVerifyRequest({
    required this.email,
    required this.otpcode,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'otpcode': otpcode});

    return result;
  }

  factory OTPVerifyRequest.fromMap(Map<String, dynamic> map) {
    return OTPVerifyRequest(
      email: map['email'] ?? '',
      otpcode: map['otpcode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPVerifyRequest.fromJson(String source) =>
      OTPVerifyRequest.fromMap(json.decode(source));
}
