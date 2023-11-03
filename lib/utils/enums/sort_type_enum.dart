enum SortType {
  asc('sellingprice_asc'),
  desc('sellingprice_desc');

  final String type;
  const SortType(this.type);
}
