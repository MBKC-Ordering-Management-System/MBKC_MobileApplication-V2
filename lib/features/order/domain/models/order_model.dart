import 'dart:convert';
import '../../../../utils/enums/order_status_type.dart';
import 'order_detail_model.dart';

class OrderModel {
  final int orderid;
  final String partner;
  final int totalItem;
  final String note;
  final OrderStatusType status;
  final String paymentMethod;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final int subtotal;
  final int discount;
  final int finalTotal;
  final List<OrderDetailModel> orderDetails;

  OrderModel({
    required this.orderid,
    required this.partner,
    required this.totalItem,
    required this.note,
    required this.status,
    required this.paymentMethod,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.subtotal,
    required this.discount,
    required this.finalTotal,
    required this.orderDetails,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'orderid': orderid});
    result.addAll({'partner': partner});
    result.addAll({'totalItem': totalItem});
    result.addAll({'note': note});
    result.addAll({'status': status.type});
    result.addAll({'paymentMethod': paymentMethod});
    result.addAll({'customerName': customerName});
    result.addAll({'customerPhone': customerPhone});
    result.addAll({'customerAddress': customerAddress});
    result.addAll({'subtotal': subtotal});
    result.addAll({'discount': discount});
    result.addAll({'finalTotal': finalTotal});
    result
        .addAll({'orderDetails': orderDetails.map((x) => x.toMap()).toList()});

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderid: map['orderid']?.toInt() ?? 0,
      partner: map['partner'] ?? '',
      totalItem: map['totalItem']?.toInt() ?? 0,
      note: map['note'] ?? '',
      status: (map['status'] as String).toOrderTypeEnum(),
      paymentMethod: map['paymentMethod'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      customerAddress: map['customerAddress'] ?? '',
      subtotal: map['subtotal']?.toInt() ?? 0,
      discount: map['discount']?.toInt() ?? 0,
      finalTotal: map['finalTotal']?.toInt() ?? 0,
      orderDetails: List<OrderDetailModel>.from(
          map['orderDetails']?.map((x) => OrderDetailModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
