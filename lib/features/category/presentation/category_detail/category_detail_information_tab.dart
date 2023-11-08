import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/field_box.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: size.height * 0.01),
          const LabelText(
            content: 'Hình ảnh',
            size: AssetsConstants.defaultFontSize - 12.0,
            color: AssetsConstants.skipText,
          ),
          SizedBox(height: size.height * 0.01),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage(
                AssetsConstants.welcomeImage,
              ),
              image: NetworkImage(
                category.imageUrl!,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }
}
