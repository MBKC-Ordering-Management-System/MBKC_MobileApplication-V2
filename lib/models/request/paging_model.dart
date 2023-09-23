import 'dart:convert';

class PagingModel {
  final int pageNumber;
  final int pageSize;

  PagingModel({
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pageNumber': pageNumber});
    result.addAll({'pageSize': pageSize});

    return result;
  }

  factory PagingModel.fromMap(Map<String, dynamic> map) {
    return PagingModel(
      pageNumber: map['pageNumber']?.toInt() ?? 0,
      pageSize: map['pageSize']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PagingModel.fromJson(String source) =>
      PagingModel.fromMap(json.decode(source));
}
