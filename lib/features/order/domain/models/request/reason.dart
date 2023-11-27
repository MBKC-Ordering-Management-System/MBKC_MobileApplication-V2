import 'dart:convert';

class Reason {
  final String? rejectedReason;

  Reason({required this.rejectedReason});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (rejectedReason != null) {
      result.addAll({'rejectedReason': rejectedReason});
    }

    return result;
  }

  factory Reason.fromMap(Map<String, dynamic> map) {
    return Reason(
      rejectedReason: map['rejectedReason'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Reason.fromJson(String source) => Reason.fromMap(json.decode(source));
}
