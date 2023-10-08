import 'dart:convert';
import '../../../profile/domain/models/brand_model.dart';

class ProductModel {
  final int productId;
  final String code;
  final String name;
  final String description;
  final int sellingPrice;
  final int discountPrice;
  final int historicalPrice;
  final String type;
  final String image;
  final String status;
  final String? size;
  final int displayOrder;
  final String? parentProductId;
  final List<ProductModel> childrenProducts;
  final int categoryId;
  final String categoryName;
  final BrandModel brand;

  ProductModel({
    required this.productId,
    required this.code,
    required this.name,
    required this.description,
    required this.sellingPrice,
    required this.discountPrice,
    required this.historicalPrice,
    required this.type,
    required this.image,
    required this.status,
    required this.size,
    required this.displayOrder,
    required this.parentProductId,
    required this.childrenProducts,
    required this.categoryId,
    required this.categoryName,
    required this.brand,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'code': code});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'sellingPrice': sellingPrice});
    result.addAll({'discountPrice': discountPrice});
    result.addAll({'historicalPrice': historicalPrice});
    result.addAll({'type': type});
    result.addAll({'image': image});
    result.addAll({'status': status});
    if (size != null) {
      result.addAll({'size': size});
    }
    result.addAll({'displayOrder': displayOrder});
    if (parentProductId != null) {
      result.addAll({'parentProductId': parentProductId});
    }
    result.addAll(
        {'childrenProducts': childrenProducts.map((x) => x.toMap()).toList()});
    result.addAll({'categoryId': categoryId});
    result.addAll({'categoryName': categoryName});
    result.addAll({'brand': brand.toMap()});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId']?.toInt() ?? 0,
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      sellingPrice: map['sellingPrice']?.toInt() ?? 0,
      discountPrice: map['discountPrice']?.toInt() ?? 0,
      historicalPrice: map['historicalPrice']?.toInt() ?? 0,
      type: map['type'] ?? '',
      image: map['image'] ?? '',
      status: map['status'] ?? '',
      size: map['size'],
      displayOrder: map['displayOrder']?.toInt() ?? 0,
      parentProductId: map['parentProductId'],
      childrenProducts: List<ProductModel>.from(
          map['childrenProducts']?.map((x) => ProductModel.fromMap(x))),
      categoryId: map['categoryId']?.toInt() ?? 0,
      categoryName: map['categoryName'] ?? '',
      brand: BrandModel.fromMap(map['brand']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
