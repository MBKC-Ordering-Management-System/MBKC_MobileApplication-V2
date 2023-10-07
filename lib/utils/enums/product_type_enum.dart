enum ProductType {
  single('Đơn'),
  parent('Cha'),
  child('Con'),
  extra('Thêm');

  final String type;
  const ProductType(this.type);
}
