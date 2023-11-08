import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/field_box.dart';
import '../../domain/models/category_model.dart';

class CategoryDetailInformationTab extends StatelessWidget {
  const CategoryDetailInformationTab({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    // intit
    final size = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Mã danh mục', content: category.code!),
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Tên danh mục', content: category.name!),
          SizedBox(height: size.height * 0.01),
          FieldBox(
            title: 'Thứ tự hiển thị',
            content: category.displayOrder!.toString(),
          ),
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Mô tả', content: category.description!),
        ],
      ),
    );
  }
}
