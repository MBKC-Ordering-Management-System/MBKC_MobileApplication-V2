import 'dart:convert';

class OrderDetailModel {
  final int productId;
  final String productName;
  final List<String> extra;
  final String note;
  final int quantity;
  final int totalPrice;

  OrderDetailModel({
    required this.productId,
    required this.productName,
    required this.extra,
    required this.note,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'productName': productName});
    result.addAll({'extra': extra});
    result.addAll({'note': note});
    result.addAll({'quantity': quantity});
    result.addAll({'totalPrice': totalPrice});

    return result;
  }

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      productId: map['productId']?.toInt() ?? 0,
      productName: map['productName'] ?? '',
      extra: List<String>.from(map['extra']),
      note: map['note'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailModel.fromJson(String source) =>
      OrderDetailModel.fromMap(json.decode(source));
}
