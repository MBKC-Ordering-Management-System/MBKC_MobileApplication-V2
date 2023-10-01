import 'dart:convert';

class AccountBankingRequest {
  final String numberAccount;
  final String name;

  AccountBankingRequest({
    required this.numberAccount,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'numberAccount': numberAccount});
    result.addAll({'name': name});

    return result;
  }

  factory AccountBankingRequest.fromMap(Map<String, dynamic> map) {
    return AccountBankingRequest(
      numberAccount: map['numberAccount'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountBankingRequest.fromJson(String source) =>
      AccountBankingRequest.fromMap(json.decode(source));
}
