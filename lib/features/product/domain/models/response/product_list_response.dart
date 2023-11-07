import 'dart:convert';
import '../product_model.dart';

class ProductListResponse {
  final int totalPages;
  final int numberItems;
  final List<ProductModel> products;

  ProductListResponse({
    required this.totalPages,
    required this.numberItems,
    required this.products,
  });

  factory ProductListResponse.fromMap(Map<String, dynamic> map) {
    return ProductListResponse(
      totalPages: map['totalPages']?.toInt() ?? 0,
      numberItems: map['numberItems']?.toInt() ?? 0,
      products: List<ProductModel>.from(
          map['products']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  factory ProductListResponse.fromJson(String source) =>
      ProductListResponse.fromMap(json.decode(source));
}
