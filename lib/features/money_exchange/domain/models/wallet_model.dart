import 'dart:convert';

class WalletModel {
  final int walletId;
  final double balance;

  WalletModel({required this.walletId, required this.balance});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'walletId': walletId});
    result.addAll({'balance': balance});

    return result;
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      walletId: map['walletId']?.toInt() ?? 0,
      balance: map['balance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));
}
