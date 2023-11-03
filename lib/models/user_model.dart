import 'dart:convert';
import 'token_model.dart';

class UserModel {
  final int id;
  final String email;
  final TokenModel token;
  UserModel({
    required this.id,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'token': token.toMap()});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      token: TokenModel.fromMap(map['token']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
