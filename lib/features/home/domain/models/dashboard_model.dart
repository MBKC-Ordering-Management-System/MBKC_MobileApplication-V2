import 'dart:convert';

class DashBoardModel {
  final int? totalUpcomingOrder;
  final int? totalPreparingOrder;
  final int? totalReadyOrder;
  final int? totalCompletedOrder;
  final double? totalRevenueDaily;

  DashBoardModel({
    required this.totalUpcomingOrder,
    required this.totalPreparingOrder,
    required this.totalReadyOrder,
    required this.totalCompletedOrder,
    required this.totalRevenueDaily,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalUpcomingOrder != null) {
      result.addAll({'totalUpcomingOrder': totalUpcomingOrder});
    }
    if (totalPreparingOrder != null) {
      result.addAll({'totalPreparingOrder': totalPreparingOrder});
    }
    if (totalReadyOrder != null) {
      result.addAll({'totalReadyOrder': totalReadyOrder});
    }
    if (totalCompletedOrder != null) {
      result.addAll({'totalCompletedOrder': totalCompletedOrder});
    }
    if (totalRevenueDaily != null) {
      result.addAll({'totalRevenueDaily': totalRevenueDaily});
    }

    return result;
  }

  factory DashBoardModel.fromMap(Map<String, dynamic> map) {
    return DashBoardModel(
      totalUpcomingOrder: map['totalUpcomingOrder']?.toInt(),
      totalPreparingOrder: map['totalPreparingOrder']?.toInt(),
      totalReadyOrder: map['totalReadyOrder']?.toInt(),
      totalCompletedOrder: map['totalCompletedOrder']?.toInt(),
      totalRevenueDaily: map['totalRevenueDaily']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashBoardModel.fromJson(String source) =>
      DashBoardModel.fromMap(json.decode(source));
}
