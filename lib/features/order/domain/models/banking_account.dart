import 'dart:convert';

class BankingAccount {
  final int? bankingAccountId;
  final String? numberAccount;
  final String? status;
  final String? name;
  final String? logoUrl;

  BankingAccount({
    required this.bankingAccountId,
    required this.numberAccount,
    required this.status,
    required this.name,
    required this.logoUrl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (bankingAccountId != null) {
      result.addAll({'bankingAccountId': bankingAccountId});
    }
    if (numberAccount != null) {
      result.addAll({'numberAccount': numberAccount});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (logoUrl != null) {
      result.addAll({'logoUrl': logoUrl});
    }

    return result;
  }

  factory BankingAccount.fromMap(Map<String, dynamic> map) {
    return BankingAccount(
      bankingAccountId: map['bankingAccountId']?.toInt(),
      numberAccount: map['numberAccount'],
      status: map['status'],
      name: map['name'],
      logoUrl: map['logoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BankingAccount.fromJson(String source) =>
      BankingAccount.fromMap(json.decode(source));
}
