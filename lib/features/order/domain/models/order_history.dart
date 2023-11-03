import 'dart:convert';

class OrderHistory {
  final int? orderHistoryId;
  final String? image;
  final String? createdDate;
  final String? systemStatus;
  final String? partnerOrderStatus;

  OrderHistory({
    required this.orderHistoryId,
    required this.image,
    required this.createdDate,
    required this.systemStatus,
    required this.partnerOrderStatus,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderHistoryId != null) {
      result.addAll({'orderHistoryId': orderHistoryId});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (createdDate != null) {
      result.addAll({'createdDate': createdDate});
    }
    if (systemStatus != null) {
      result.addAll({'systemStatus': systemStatus});
    }
    if (partnerOrderStatus != null) {
      result.addAll({'partnerOrderStatus': partnerOrderStatus});
    }

    return result;
  }

  factory OrderHistory.fromMap(Map<String, dynamic> map) {
    return OrderHistory(
      orderHistoryId: map['orderHistoryId']?.toInt(),
      image: map['image'],
      createdDate: map['createdDate'],
      systemStatus: map['systemStatus'],
      partnerOrderStatus: map['partnerOrderStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistory.fromJson(String source) =>
      OrderHistory.fromMap(json.decode(source));
}
