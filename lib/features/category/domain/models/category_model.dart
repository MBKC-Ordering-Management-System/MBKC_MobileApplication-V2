import 'dart:convert';

import '../../../../utils/enums/enums_export.dart';

class CategoryModel {
  final int? categoryId;
  final String? code;
  final String? name;
  final CategoryType? type;
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

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId']?.toInt(),
      code: map['code'],
      name: map['name'],
      type: map['type'] != null
          ? (map['type'] as String).toCategoryTypeEnum()
          : null,
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

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
