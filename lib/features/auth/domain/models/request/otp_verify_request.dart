import 'dart:convert';

class OTPVerifyRequest {
  final String email;
  final String otpCode;

  OTPVerifyRequest({
    required this.email,
    required this.otpCode,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'otpCode': otpCode});

    return result;
  }

  factory OTPVerifyRequest.fromMap(Map<String, dynamic> map) {
    return OTPVerifyRequest(
      email: map['email'] ?? '',
      otpCode: map['otpCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPVerifyRequest.fromJson(String source) =>
      OTPVerifyRequest.fromMap(json.decode(source));
}
