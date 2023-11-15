import 'dart:convert';

import 'token_model.dart';

class UserModel {
  final int? accountId;
  final int? storeId;
  final String email;
  final TokenModel token;

  UserModel({
    required this.accountId,
    required this.storeId,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (accountId != null) {
      result.addAll({'accountId': accountId});
    }
    if (storeId != null) {
      result.addAll({'storeId': storeId});
    }
    result.addAll({'email': email});
    result.addAll({'token': token.toMap()});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      accountId: map['accountId']?.toInt(),
      storeId: map['storeId']?.toInt(),
      email: map['email'] ?? '',
      token: TokenModel.fromMap(map['token']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
