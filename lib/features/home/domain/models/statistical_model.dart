import 'dart:convert';

class StatisticalModel {
  final String totalRevenue;
  final String totalOrder;

  StatisticalModel({
    required this.totalRevenue,
    required this.totalOrder,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'totalRevenue': totalRevenue});
    result.addAll({'totalOrder': totalOrder});

    return result;
  }

  factory StatisticalModel.fromMap(Map<String, dynamic> map) {
    return StatisticalModel(
      totalRevenue: map['totalRevenue'] ?? '',
      totalOrder: map['totalOrder'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticalModel.fromJson(String source) =>
      StatisticalModel.fromMap(json.decode(source));
}
