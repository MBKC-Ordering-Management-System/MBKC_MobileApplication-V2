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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'totalPages': totalPages});
    result.addAll({'numberItems': numberItems});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProductListResponse.fromMap(Map<String, dynamic> map) {
    return ProductListResponse(
      totalPages: map['totalPages']?.toInt() ?? 0,
      numberItems: map['numberItems']?.toInt() ?? 0,
      products: List<ProductModel>.from(
          map['products']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductListResponse.fromJson(String source) =>
      ProductListResponse.fromMap(json.decode(source));
}
