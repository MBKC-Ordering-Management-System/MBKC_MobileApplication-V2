import 'dart:convert';
import '../../../../utils/enums/money_exchange_type_enum.dart';

class MoneyExchangeModel {
  final int? exchangeId;
  final double? amount;
  final MoneyExchangeType? exchangeType;
  final String? content;
  final String? status;
  final int? senderId;
  final String? senderName;
  final int? receiveId;
  final String? receiveName;
  final String? createdDate;
  final String? exchangeImage;
  final String? transactionTime;

  MoneyExchangeModel({
    required this.exchangeId,
    required this.amount,
    required this.exchangeType,
    required this.content,
    required this.status,
    required this.senderId,
    required this.senderName,
    required this.receiveId,
    required this.receiveName,
    required this.createdDate,
    required this.exchangeImage,
    required this.transactionTime,
  });

  factory MoneyExchangeModel.fromMap(Map<String, dynamic> map) {
    return MoneyExchangeModel(
      exchangeId: map['exchangeId']?.toInt(),
      amount: map['amount']?.toDouble(),
      exchangeType: map['exchangeType'] != null
          ? (map['exchangeType'] as String).toMoneyExchangeTypeEnum()
          : null,
      content: map['content'],
      status: map['status'],
      senderId: map['senderId']?.toInt(),
      senderName: map['senderName'],
      receiveId: map['receiveId']?.toInt(),
      receiveName: map['receiveName'],
      createdDate: map['createdDate'],
      exchangeImage: map['exchangeImage'],
      transactionTime: map['transactionTime'],
    );
  }

  factory MoneyExchangeModel.fromJson(String source) =>
      MoneyExchangeModel.fromMap(json.decode(source));
}
