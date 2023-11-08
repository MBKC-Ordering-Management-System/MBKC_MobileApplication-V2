import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../domain/models/category_model.dart';
import '../category_list/category_item.dart';

class CategoryDetailExtraTab extends StatelessWidget {
  const CategoryDetailExtraTab({super.key, required this.categoriesExtra});
  final List<CategoryModel> categoriesExtra;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: categoriesExtra.isEmpty
          ? const Align(
              alignment: Alignment.topCenter,
              child: EmptyBox(title: 'Không có danh mục'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: categoriesExtra.length,
              itemBuilder: (_, index) => CategoryItem(
                category: categoriesExtra[index],
              ),
            ),
    );
  }
}
