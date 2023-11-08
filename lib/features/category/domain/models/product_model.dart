import 'dart:convert';
import '../../../../utils/enums/product_type_enum.dart';
import '../../../profile/domain/models/brand_model.dart';

class ProductModel {
  final int productId;
  final String code;
  final String name;
  final String description;
  final int sellingPrice;
  final int discountPrice;
  final int historicalPrice;
  final ProductType type;
  final String image;
  final String status;
  final String? size;
  final int displayOrder;
  final int? parentProductId;
  final List<ProductModel>? childrenProducts;
  final List<ProductModel>? extraProducts;
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
    required this.extraProducts,
    required this.categoryId,
    required this.categoryName,
    required this.brand,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId']?.toInt() ?? 0,
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      sellingPrice: map['sellingPrice']?.toInt() ?? 0,
      discountPrice: map['discountPrice']?.toInt() ?? 0,
      historicalPrice: map['historicalPrice']?.toInt() ?? 0,
      type: (map['type'] as String).toProductTypeEnum(),
      image: map['image'] ?? '',
      status: map['status'] ?? '',
      size: map['size'],
      displayOrder: map['displayOrder']?.toInt() ?? 0,
      parentProductId: map['parentProductId']?.toInt(),
      childrenProducts: map['childrenProducts'] != null
          ? List<ProductModel>.from(
              map['childrenProducts']?.map((x) => ProductModel.fromMap(x)))
          : null,
      extraProducts: map['extraProducts'] != null
          ? List<ProductModel>.from(
              map['extraProducts']?.map((x) => ProductModel.fromMap(x)))
          : null,
      categoryId: map['categoryId']?.toInt() ?? 0,
      categoryName: map['categoryName'] ?? '',
      brand: BrandModel.fromMap(map['brand']),
    );
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
