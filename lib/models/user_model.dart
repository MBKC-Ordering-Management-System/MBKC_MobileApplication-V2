import 'dart:convert';
import 'token_model.dart';
import 'user_token.dart';

class UserModel {
  final int? accountId;
  final int? storeId;
  final String email;
  final TokenModel token;
  final String? fcmToken;
  final List<UserDevice>? userTokens;

  UserModel({
    required this.accountId,
    required this.storeId,
    required this.email,
    required this.token,
    this.fcmToken,
    this.userTokens,
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
    if (fcmToken != null) {
      result.addAll({'fcmToken': fcmToken});
    }
    if (userTokens != null) {
      result.addAll({'userTokens': userTokens!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      accountId: map['accountId']?.toInt(),
      storeId: map['storeId']?.toInt(),
      email: map['email'] ?? '',
      token: TokenModel.fromMap(map['token']),
      fcmToken: map['fcmToken'],
      userTokens: map['userTokens'] != null
          ? List<UserDevice>.from(
              map['userTokens']?.map((x) => UserDevice.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    int? accountId,
    int? storeId,
    String? email,
    TokenModel? token,
    String? fcmToken,
    List<UserDevice>? userTokens,
  }) {
    return UserModel(
      accountId: accountId ?? this.accountId,
      storeId: storeId ?? this.storeId,
      email: email ?? this.email,
      token: token ?? this.token,
      fcmToken: fcmToken ?? this.fcmToken,
      userTokens: userTokens ?? this.userTokens,
    );
  }
}
