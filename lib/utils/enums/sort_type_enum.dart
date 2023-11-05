enum SortType {
  asc('sellingprice_ASC'),
  desc('sellingprice_DESC');

  final String type;
  const SortType(this.type);
}
