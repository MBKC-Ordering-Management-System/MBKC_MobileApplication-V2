import 'dart:convert';

class Partner {
  final int? partnerId;
  final String? name;
  final String? logo;
  final String? webUrl;
  final String? status;

  Partner({
    required this.partnerId,
    required this.name,
    required this.logo,
    required this.webUrl,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (partnerId != null) {
      result.addAll({'partnerId': partnerId});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (logo != null) {
      result.addAll({'logo': logo});
    }
    if (webUrl != null) {
      result.addAll({'webUrl': webUrl});
    }
    if (status != null) {
      result.addAll({'status': status});
    }

    return result;
  }

  factory Partner.fromMap(Map<String, dynamic> map) {
    return Partner(
      partnerId: map['partnerId']?.toInt(),
      name: map['name'],
      logo: map['logo'],
      webUrl: map['webUrl'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Partner.fromJson(String source) =>
      Partner.fromMap(json.decode(source));
}
