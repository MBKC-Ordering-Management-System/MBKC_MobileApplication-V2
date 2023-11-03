import 'dart:convert';

class Product {
  final int? productId;
  final String? code;
  final String? name;
  final String? description;
  final int? sellingPrice;
  final int? discountPrice;
  final int? historicalPrice;
  final String? type;
  final String? image;
  final String? status;
  final String? size;
  final int? displayOrder;
  final String? parentProductId;
  final List<Product>? childrenProducts;
  final int? categoryId;
  final String? categoryName;

  Product({
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
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (productId != null) {
      result.addAll({'productId': productId});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (sellingPrice != null) {
      result.addAll({'sellingPrice': sellingPrice});
    }
    if (discountPrice != null) {
      result.addAll({'discountPrice': discountPrice});
    }
    if (historicalPrice != null) {
      result.addAll({'historicalPrice': historicalPrice});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (size != null) {
      result.addAll({'size': size});
    }
    if (displayOrder != null) {
      result.addAll({'displayOrder': displayOrder});
    }
    if (parentProductId != null) {
      result.addAll({'parentProductId': parentProductId});
    }
    if (childrenProducts != null) {
      result.addAll({
        'childrenProducts': childrenProducts!.map((x) => x.toMap()).toList()
      });
    }
    if (categoryId != null) {
      result.addAll({'categoryId': categoryId});
    }
    if (categoryName != null) {
      result.addAll({'categoryName': categoryName});
    }

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId']?.toInt(),
      code: map['code'],
      name: map['name'],
      description: map['description'],
      sellingPrice: map['sellingPrice']?.toInt(),
      discountPrice: map['discountPrice']?.toInt(),
      historicalPrice: map['historicalPrice']?.toInt(),
      type: map['type'],
      image: map['image'],
      status: map['status'],
      size: map['size'],
      displayOrder: map['displayOrder']?.toInt(),
      parentProductId: map['parentProductId'],
      childrenProducts: map['childrenProducts'] != null
          ? List<Product>.from(
              map['childrenProducts']?.map((x) => Product.fromMap(x)))
          : null,
      categoryId: map['categoryId']?.toInt(),
      categoryName: map['categoryName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
