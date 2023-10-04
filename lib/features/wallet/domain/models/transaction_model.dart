import 'dart:convert';

import '../../../../utils/enums/transaction_type_enum.dart';

class TransactionModel {
  final int id;
  final int amout;
  final int balance;
  final String from;
  final String to;
  final String date;
  final TransactionType type;
  final String status;
  final String content;

  TransactionModel({
    required this.id,
    required this.amout,
    required this.balance,
    required this.from,
    required this.to,
    required this.date,
    required this.type,
    required this.status,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'amout': amout});
    result.addAll({'balance': balance});
    result.addAll({'from': from});
    result.addAll({'to': to});
    result.addAll({'date': date});
    result.addAll({'type': type.type});
    result.addAll({'status': status});
    result.addAll({'content': content});

    return result;
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id']?.toInt() ?? 0,
      amout: map['amout']?.toInt() ?? 0,
      balance: map['balance']?.toInt() ?? 0,
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      date: map['date'] ?? '',
      type: (map['type'] as int).toTransactionTypeEnum(),
      status: map['status'] ?? '',
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}
