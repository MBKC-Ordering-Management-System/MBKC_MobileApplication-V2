enum ProductType {
  single('SINGLE'),
  parent('PARENT'),
  child('CHILD'),
  extra('EXTRA');

  final String type;
  const ProductType(this.type);
}

extension ConvertProductType on String {
  ProductType toProductTypeEnum() {
    switch (this) {
      case 'SINGLE':
        return ProductType.single;
      case 'PARENT':
        return ProductType.parent;
      case 'CHILD':
        return ProductType.child;
      case 'EXTRA':
        return ProductType.extra;

      default:
        return ProductType.single;
    }
  }
}
