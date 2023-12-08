import 'dart:convert';

import 'product.dart';

class OrderDetail {
  final int? orderDetailId;
  final int? sellingPrice;
  final int? quantity;
  final String? note;
  final int? orderId;
  final int? masterOrderDetail;
  final int? discountPrice;
  final List<OrderDetail>? extraOrderDetails;
  final Product? product;

  OrderDetail({
    required this.orderDetailId,
    required this.sellingPrice,
    required this.quantity,
    required this.note,
    required this.orderId,
    required this.masterOrderDetail,
    required this.discountPrice,
    required this.extraOrderDetails,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderDetailId != null) {
      result.addAll({'orderDetailId': orderDetailId});
    }
    if (sellingPrice != null) {
      result.addAll({'sellingPrice': sellingPrice});
    }
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }
    if (note != null) {
      result.addAll({'note': note});
    }
    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (masterOrderDetail != null) {
      result.addAll({'masterOrderDetail': masterOrderDetail});
    }
    if (discountPrice != null) {
      result.addAll({'discountPrice': discountPrice});
    }
    if (extraOrderDetails != null) {
      result.addAll({
        'extraOrderDetails': extraOrderDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (product != null) {
      result.addAll({'product': product!.toMap()});
    }

    return result;
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      orderDetailId: map['orderDetailId']?.toInt(),
      sellingPrice: map['sellingPrice']?.toInt(),
      quantity: map['quantity']?.toInt(),
      note: map['note'],
      orderId: map['orderId']?.toInt(),
      masterOrderDetail: map['masterOrderDetail']?.toInt(),
      discountPrice: map['discountPrice']?.toInt(),
      extraOrderDetails: map['extraOrderDetails'] != null
          ? List<OrderDetail>.from(
              map['extraOrderDetails']?.map((x) => OrderDetail.fromMap(x)))
          : null,
      product: map['product'] != null ? Product.fromMap(map['product']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source));
}
