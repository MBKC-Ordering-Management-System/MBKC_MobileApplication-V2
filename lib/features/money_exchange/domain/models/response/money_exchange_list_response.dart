import 'dart:convert';

import '../money_exchange_model.dart';

class MoneyExchangeListResponse {
  final int totalPages;
  final int numberItems;
  final List<MoneyExchangeModel> moneyExchanges;

  MoneyExchangeListResponse({
    required this.totalPages,
    required this.numberItems,
    required this.moneyExchanges,
  });

  factory MoneyExchangeListResponse.fromMap(Map<String, dynamic> map) {
    return MoneyExchangeListResponse(
      totalPages: map['totalPages']?.toInt() ?? 0,
      numberItems: map['numberItems']?.toInt() ?? 0,
      moneyExchanges: List<MoneyExchangeModel>.from(
          map['moneyExchanges']?.map((x) => MoneyExchangeModel.fromMap(x))),
    );
  }

  factory MoneyExchangeListResponse.fromJson(String source) =>
      MoneyExchangeListResponse.fromMap(json.decode(source));
}
