import 'dart:convert';

class DashBoardModel {
  final int? totalUpcomingOrders;
  final int? totalPreparingOrders;
  final int? totalReadyOrders;
  final int? totalCompletedOrders;
  final double? totalRevenuesDaily;

  DashBoardModel({
    required this.totalUpcomingOrders,
    required this.totalPreparingOrders,
    required this.totalReadyOrders,
    required this.totalCompletedOrders,
    required this.totalRevenuesDaily,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalUpcomingOrders != null) {
      result.addAll({'totalUpcomingOrders': totalUpcomingOrders});
    }
    if (totalPreparingOrders != null) {
      result.addAll({'totalPreparingOrders': totalPreparingOrders});
    }
    if (totalReadyOrders != null) {
      result.addAll({'totalReadyOrders': totalReadyOrders});
    }
    if (totalCompletedOrders != null) {
      result.addAll({'totalCompletedOrders': totalCompletedOrders});
    }
    if (totalRevenuesDaily != null) {
      result.addAll({'totalRevenuesDaily': totalRevenuesDaily});
    }

    return result;
  }

  factory DashBoardModel.fromMap(Map<String, dynamic> map) {
    return DashBoardModel(
      totalUpcomingOrders: map['totalUpcomingOrders']?.toInt(),
      totalPreparingOrders: map['totalPreparingOrders']?.toInt(),
      totalReadyOrders: map['totalReadyOrders']?.toInt(),
      totalCompletedOrders: map['totalCompletedOrders']?.toInt(),
      totalRevenuesDaily: map['totalRevenuesDaily']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashBoardModel.fromJson(String source) =>
      DashBoardModel.fromMap(json.decode(source));
}
