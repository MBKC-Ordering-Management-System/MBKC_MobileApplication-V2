import 'dart:convert';

class SignInRequest {
  final String username;
  final String password;

  SignInRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'password': password});

    return result;
  }

  factory SignInRequest.fromMap(Map<String, dynamic> map) {
    return SignInRequest(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInRequest.fromJson(String source) =>
      SignInRequest.fromMap(json.decode(source));
}
