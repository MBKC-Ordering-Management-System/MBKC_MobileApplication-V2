import 'dart:convert';

import 'brand_model.dart';
import 'kitchen_center_model.dart';

class ProfileModel {
  final int storeId;
  final String name;
  final String status;
  final String logo;
  final String storeManagerEmail;
  final String? rejectedReason;
  final KitchenCenterModel? kitchenCenter;
  final BrandModel brand;

  ProfileModel({
    required this.storeId,
    required this.name,
    required this.status,
    required this.logo,
    required this.storeManagerEmail,
    required this.rejectedReason,
    required this.kitchenCenter,
    required this.brand,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'storeId': storeId});
    result.addAll({'name': name});
    result.addAll({'status': status});
    result.addAll({'logo': logo});
    result.addAll({'storeManagerEmail': storeManagerEmail});
    if (rejectedReason != null) {
      result.addAll({'rejectedReason': rejectedReason});
    }
    if (kitchenCenter != null) {
      result.addAll({'kitchenCenter': kitchenCenter!.toMap()});
    }
    result.addAll({'brand': brand.toMap()});

    return result;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      storeId: map['storeId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      logo: map['logo'] ?? '',
      storeManagerEmail: map['storeManagerEmail'] ?? '',
      rejectedReason: map['rejectedReason'],
      kitchenCenter: map['kitchenCenter'] != null
          ? KitchenCenterModel.fromMap(map['kitchenCenter'])
          : null,
      brand: BrandModel.fromMap(map['brand']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));
}
