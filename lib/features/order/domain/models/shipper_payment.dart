import 'dart:convert';

class ShipperPayment {
  final int? paymentId;
  final int? status;
  final String? content;
  final int? amount;
  final String? createDate;
  final int? createdBy;
  final String? cashierCreated;

  ShipperPayment({
    required this.paymentId,
    required this.status,
    required this.content,
    required this.amount,
    required this.createDate,
    required this.createdBy,
    required this.cashierCreated,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (paymentId != null) {
      result.addAll({'paymentId': paymentId});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (content != null) {
      result.addAll({'content': content});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (createDate != null) {
      result.addAll({'createDate': createDate});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (cashierCreated != null) {
      result.addAll({'cashierCreated': cashierCreated});
    }

    return result;
  }

  factory ShipperPayment.fromMap(Map<String, dynamic> map) {
    return ShipperPayment(
      paymentId: map['paymentId']?.toInt(),
      status: map['status']?.toInt(),
      content: map['content'],
      amount: map['amount']?.toInt(),
      createDate: map['createDate'],
      createdBy: map['createdBy']?.toInt(),
      cashierCreated: map['cashierCreated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipperPayment.fromJson(String source) =>
      ShipperPayment.fromMap(json.decode(source));
}
