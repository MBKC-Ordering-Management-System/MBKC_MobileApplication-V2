import 'dart:convert';

class ProductModel {
  final int productId;
  final String image;
  final String code;
  final String name;
  final String description;
  final int sellingPrice;
  final int discountPrice;
  final String size;
  final String shopeeCode;
  final String grabCode;
  final String beaminCode;
  final String category;
  final List<ProductModel> childs;

  ProductModel({
    required this.productId,
    required this.image,
    required this.code,
    required this.name,
    required this.description,
    required this.sellingPrice,
    required this.discountPrice,
    required this.size,
    required this.shopeeCode,
    required this.grabCode,
    required this.beaminCode,
    required this.category,
    required this.childs,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'image': image});
    result.addAll({'code': code});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'sellingPrice': sellingPrice});
    result.addAll({'discountPrice': discountPrice});
    result.addAll({'size': size});
    result.addAll({'shopeeCode': shopeeCode});
    result.addAll({'grabCode': grabCode});
    result.addAll({'beaminCode': beaminCode});
    result.addAll({'category': category});
    result.addAll({'childs': childs.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId']?.toInt() ?? 0,
      image: map['image'] ?? '',
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      sellingPrice: map['sellingPrice']?.toInt() ?? 0,
      discountPrice: map['discountPrice']?.toInt() ?? 0,
      size: map['size'] ?? '',
      shopeeCode: map['shopeeCode'] ?? '',
      grabCode: map['grabCode'] ?? '',
      beaminCode: map['beaminCode'] ?? '',
      category: map['category'] ?? '',
      childs: List<ProductModel>.from(
          map['childs']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
