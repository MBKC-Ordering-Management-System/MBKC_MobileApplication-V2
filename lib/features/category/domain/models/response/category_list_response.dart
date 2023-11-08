import 'dart:convert';
import '../category_model.dart';

class CategoryListResponse {
  final int totalPages;
  final int numberItems;
  final List<CategoryModel> categories;

  CategoryListResponse({
    required this.totalPages,
    required this.numberItems,
    required this.categories,
  });

  factory CategoryListResponse.fromMap(Map<String, dynamic> map) {
    return CategoryListResponse(
      totalPages: map['totalPages']?.toInt() ?? 0,
      numberItems: map['numberItems']?.toInt() ?? 0,
      categories: List<CategoryModel>.from(
          map['categories']?.map((x) => CategoryModel.fromMap(x))),
    );
  }

  factory CategoryListResponse.fromJson(String source) =>
      CategoryListResponse.fromMap(json.decode(source));
}
