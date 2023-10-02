import 'dart:convert';

class KitchenCenterModel {
  final int kitchenCenterId;
  final String name;
  final String address;
  final String status;
  final String logo;
  final String kitchenCenterManagerEmail;

  KitchenCenterModel({
    required this.kitchenCenterId,
    required this.name,
    required this.address,
    required this.status,
    required this.logo,
    required this.kitchenCenterManagerEmail,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'kitchenCenterId': kitchenCenterId});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'status': status});
    result.addAll({'logo': logo});
    result.addAll({'kitchenCenterManagerEmail': kitchenCenterManagerEmail});

    return result;
  }

  factory KitchenCenterModel.fromMap(Map<String, dynamic> map) {
    return KitchenCenterModel(
      kitchenCenterId: map['kitchenCenterId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      status: map['status'] ?? '',
      logo: map['logo'] ?? '',
      kitchenCenterManagerEmail: map['kitchenCenterManagerEmail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory KitchenCenterModel.fromJson(String source) =>
      KitchenCenterModel.fromMap(json.decode(source));
}
