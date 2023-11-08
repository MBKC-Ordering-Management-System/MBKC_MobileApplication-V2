enum CategoryType {
  normal('NORMAL'),
  extra('EXTRA');

  final String type;
  const CategoryType(this.type);
}

extension ConvertCategoryType on String {
  CategoryType toCategoryTypeEnum() {
    switch (this) {
      case 'Normal':
        return CategoryType.normal;
      case 'Extra':
        return CategoryType.extra;
      default:
        return CategoryType.normal;
    }
  }
}
