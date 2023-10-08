enum ProductType {
  single('single'),
  parent('parent'),
  child('child'),
  extra('extra');

  final String type;
  const ProductType(this.type);
}
