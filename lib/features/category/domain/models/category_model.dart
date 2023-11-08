import 'dart:convert';

class CategoryModel {
  final int? categoryId;
  final String? code;
  final String? name;
  final String? type;
  final int? displayOrder;
  final String? description;
  final String? imageUrl;
  final String? status;
  final List<CategoryModel>? extraCategories;

  CategoryModel({
    required this.categoryId,
    required this.code,
    required this.name,
    required this.type,
    required this.displayOrder,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.extraCategories,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (categoryId != null) {
      result.addAll({'categoryId': categoryId});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (displayOrder != null) {
      result.addAll({'displayOrder': displayOrder});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (extraCategories != null) {
      result.addAll(
          {'extraCategories': extraCategories!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId']?.toInt(),
      code: map['code'],
      name: map['name'],
      type: map['type'],
      displayOrder: map['displayOrder']?.toInt(),
      description: map['description'],
      imageUrl: map['imageUrl'],
      status: map['status'],
      extraCategories: map['extraCategories'] != null
          ? List<CategoryModel>.from(
              map['extraCategories']?.map((x) => CategoryModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
