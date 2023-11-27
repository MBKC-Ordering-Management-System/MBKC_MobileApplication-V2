import 'dart:convert';
import 'order_detail.dart';
import 'order_history.dart';
import 'partner.dart';
import 'shipper_payment.dart';

class OrderModel {
  final int? id;
  final String? orderPartnerId;
  final String? shipperName;
  final String? shipperPhone;
  final String? customerName;
  final String? customerPhone;
  final String? note;
  final String? paymentMethod;
  final int? deliveryFee;
  final int? subTotalPrice;
  final int? totalDiscount;
  final int? finalTotalPrice;
  final double? collectedPrice;
  final bool? isPaid;
  final double? commission;
  final double? tax;
  final String? systemStatus;
  final String? displayId;
  final String? address;
  final int? cutlery;
  final int? totalQuantity;
  final String? rejectedReason;
  final double? storePartnerCommission;
  final String? partnerOrderStatus;
  final Partner? partner;
  final List<ShipperPayment>? shipperPayments;
  final List<OrderDetail>? orderDetails;
  final List<OrderHistory>? orderHistories;

  OrderModel({
    required this.id,
    required this.orderPartnerId,
    required this.shipperName,
    required this.shipperPhone,
    required this.customerName,
    required this.customerPhone,
    required this.note,
    required this.paymentMethod,
    required this.deliveryFee,
    required this.subTotalPrice,
    required this.totalDiscount,
    required this.finalTotalPrice,
    required this.collectedPrice,
    required this.isPaid,
    required this.commission,
    required this.tax,
    required this.systemStatus,
    required this.displayId,
    required this.address,
    required this.cutlery,
    required this.totalQuantity,
    required this.rejectedReason,
    required this.storePartnerCommission,
    required this.partnerOrderStatus,
    required this.partner,
    required this.shipperPayments,
    required this.orderDetails,
    required this.orderHistories,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (orderPartnerId != null) {
      result.addAll({'orderPartnerId': orderPartnerId});
    }
    if (shipperName != null) {
      result.addAll({'shipperName': shipperName});
    }
    if (shipperPhone != null) {
      result.addAll({'shipperPhone': shipperPhone});
    }
    if (customerName != null) {
      result.addAll({'customerName': customerName});
    }
    if (customerPhone != null) {
      result.addAll({'customerPhone': customerPhone});
    }
    if (note != null) {
      result.addAll({'note': note});
    }
    if (paymentMethod != null) {
      result.addAll({'paymentMethod': paymentMethod});
    }
    if (deliveryFee != null) {
      result.addAll({'deliveryFee': deliveryFee});
    }
    if (subTotalPrice != null) {
      result.addAll({'subTotalPrice': subTotalPrice});
    }
    if (totalDiscount != null) {
      result.addAll({'totalDiscount': totalDiscount});
    }
    if (finalTotalPrice != null) {
      result.addAll({'finalTotalPrice': finalTotalPrice});
    }
    if (collectedPrice != null) {
      result.addAll({'collectedPrice': collectedPrice});
    }
    if (isPaid != null) {
      result.addAll({'isPaid': isPaid});
    }
    if (commission != null) {
      result.addAll({'commission': commission});
    }
    if (tax != null) {
      result.addAll({'tax': tax});
    }
    if (systemStatus != null) {
      result.addAll({'systemStatus': systemStatus});
    }
    if (displayId != null) {
      result.addAll({'displayId': displayId});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (cutlery != null) {
      result.addAll({'cutlery': cutlery});
    }
    if (totalQuantity != null) {
      result.addAll({'totalQuantity': totalQuantity});
    }
    if (rejectedReason != null) {
      result.addAll({'rejectedReason': rejectedReason});
    }
    if (storePartnerCommission != null) {
      result.addAll({'storePartnerCommission': storePartnerCommission});
    }
    if (partnerOrderStatus != null) {
      result.addAll({'partnerOrderStatus': partnerOrderStatus});
    }
    if (partner != null) {
      result.addAll({'partner': partner!.toMap()});
    }
    if (shipperPayments != null) {
      result.addAll(
          {'shipperPayments': shipperPayments!.map((x) => x.toMap()).toList()});
    }
    if (orderDetails != null) {
      result.addAll(
          {'orderDetails': orderDetails!.map((x) => x.toMap()).toList()});
    }
    if (orderHistories != null) {
      result.addAll(
          {'orderHistories': orderHistories!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt(),
      orderPartnerId: map['orderPartnerId'],
      shipperName: map['shipperName'],
      shipperPhone: map['shipperPhone'],
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      note: map['note'],
      paymentMethod: map['paymentMethod'],
      deliveryFee: map['deliveryFee']?.toInt(),
      subTotalPrice: map['subTotalPrice']?.toInt(),
      totalDiscount: map['totalDiscount']?.toInt(),
      finalTotalPrice: map['finalTotalPrice']?.toInt(),
      collectedPrice: map['collectedPrice']?.toDouble(),
      isPaid: map['isPaid'],
      commission: map['commission']?.toDouble(),
      tax: map['tax']?.toDouble(),
      systemStatus: map['systemStatus'],
      displayId: map['displayId'],
      address: map['address'],
      cutlery: map['cutlery']?.toInt(),
      totalQuantity: map['totalQuantity']?.toInt(),
      rejectedReason: map['rejectedReason'],
      storePartnerCommission: map['storePartnerCommission']?.toDouble(),
      partnerOrderStatus: map['partnerOrderStatus'],
      partner: map['partner'] != null ? Partner.fromMap(map['partner']) : null,
      shipperPayments: map['shipperPayments'] != null
          ? List<ShipperPayment>.from(
              map['shipperPayments']?.map((x) => ShipperPayment.fromMap(x)))
          : null,
      orderDetails: map['orderDetails'] != null
          ? List<OrderDetail>.from(
              map['orderDetails']?.map((x) => OrderDetail.fromMap(x)))
          : null,
      orderHistories: map['orderHistories'] != null
          ? List<OrderHistory>.from(
              map['orderHistories']?.map((x) => OrderHistory.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
