import 'dart:convert';

class BankingAccountModel {
  final int id;
  final String numberAccount;
  final String name;
  final String logoUrl;

  BankingAccountModel({
    required this.id,
    required this.numberAccount,
    required this.name,
    required this.logoUrl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'numberAccount': numberAccount});
    result.addAll({'name': name});
    result.addAll({'logoUrl': logoUrl});

    return result;
  }

  factory BankingAccountModel.fromMap(Map<String, dynamic> map) {
    return BankingAccountModel(
      id: map['id']?.toInt() ?? 0,
      numberAccount: map['numberAccount'] ?? '',
      name: map['name'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BankingAccountModel.fromJson(String source) =>
      BankingAccountModel.fromMap(json.decode(source));
}
