import 'dart:convert';
import '../order_model.dart';

class OrderListResponse {
  final int totalPages;
  final int numberItems;
  final List<OrderModel> orders;

  OrderListResponse({
    required this.totalPages,
    required this.numberItems,
    required this.orders,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'totalPages': totalPages});
    result.addAll({'numberItems': numberItems});
    result.addAll({'orders': orders.map((x) => x.toMap()).toList()});

    return result;
  }

  factory OrderListResponse.fromMap(Map<String, dynamic> map) {
    return OrderListResponse(
      totalPages: map['totalPages']?.toInt() ?? 0,
      numberItems: map['numberItems']?.toInt() ?? 0,
      orders: List<OrderModel>.from(
          map['orders']?.map((x) => OrderModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderListResponse.fromJson(String source) =>
      OrderListResponse.fromMap(json.decode(source));
}
