import 'dart:convert';
import '../transaction_model.dart';

class MoneyExchangeListResponse {
  final int totalPages;
  final int numberItems;
  final List<TransactionModel> transactions;

  MoneyExchangeListResponse({
    required this.totalPages,
    required this.numberItems,
    required this.transactions,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'totalPages': totalPages});
    result.addAll({'numberItems': numberItems});
    result
        .addAll({'transactions': transactions.map((x) => x.toMap()).toList()});

    return result;
  }

  factory MoneyExchangeListResponse.fromMap(Map<String, dynamic> map) {
    return MoneyExchangeListResponse(
      totalPages: map['totalPages']?.toInt() ?? 0,
      numberItems: map['numberItems']?.toInt() ?? 0,
      transactions: List<TransactionModel>.from(
          map['transactions']?.map((x) => TransactionModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MoneyExchangeListResponse.fromJson(String source) =>
      MoneyExchangeListResponse.fromMap(json.decode(source));
}
