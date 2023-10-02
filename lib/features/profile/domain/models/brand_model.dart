import 'dart:convert';

class BrandModel {
  final int brandId;
  final String name;
  final String address;
  final String logo;
  final String status;
  final String brandManagerEmail;

  BrandModel({
    required this.brandId,
    required this.name,
    required this.address,
    required this.logo,
    required this.status,
    required this.brandManagerEmail,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'brandId': brandId});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'logo': logo});
    result.addAll({'status': status});
    result.addAll({'brandManagerEmail': brandManagerEmail});

    return result;
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      brandId: map['brandId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      logo: map['logo'] ?? '',
      status: map['status'] ?? '',
      brandManagerEmail: map['brandManagerEmail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source));
}
