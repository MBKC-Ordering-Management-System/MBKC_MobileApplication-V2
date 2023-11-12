import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
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
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LabelText(
                  content: category.name!,
                  size: AssetsConstants.defaultFontSize - 12.0,
                  fontWeight: FontWeight.bold,
                  maxLine: 3,
                ),
              ),
              SizedBox(width: size.width * 0.01),
              CustomLabelStatus(
                width: size.width * 0.3,
                height: size.height * 0.04,
                content: category.status!.toStatusTypeEnum().type,
                size: AssetsConstants.defaultFontSize - 18.0,
                backgroundColor: getBackgrounStatusColor(
                    category.status!.toStatusTypeEnum()),
                contentColor:
                    getContentStatusColor(category.status!.toStatusTypeEnum()),
              )
            ],
          ),
          SizedBox(height: size.height * 0.01),
          ContentBox(label: 'Mã:', content: category.code!),
          SizedBox(height: size.height * 0.01),
          ContentBox(
            label: 'Loại:',
            content: getTitleCategoryType(category.type!),
          ),
          SizedBox(height: size.height * 0.01),
          ContentBox(
            label: 'Thứ tự hiển thị:',
            content: category.displayOrder!.toString(),
          ),
          SizedBox(height: size.height * 0.01),
          const LabelText(
            content: 'Mô tả:',
            size: AssetsConstants.defaultFontSize - 12.0,
            color: AssetsConstants.skipText,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: size.height * 0.01),
          LabelText(
            content: category.description!,
            size: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.w600,
          ),
          const LinearHorizontal(),
          SizedBox(height: size.height * 0.01),
          const LabelText(
            content: 'Hình ảnh',
            size: AssetsConstants.defaultFontSize - 12.0,
            color: AssetsConstants.skipText,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
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
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }
}
