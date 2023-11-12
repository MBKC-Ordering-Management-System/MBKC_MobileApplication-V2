import 'package:flutter/material.dart';
import '../../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../../utils/constants/asset_constant.dart';
import '../../../../../utils/enums/enums_export.dart';
import '../../../domain/models/product_model.dart';

class InformationTab extends StatelessWidget {
  const InformationTab({super.key, required this.product});
  final ProductModel product;

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
                  content: product.name,
                  size: AssetsConstants.defaultFontSize - 12.0,
                  fontWeight: FontWeight.bold,
                  maxLine: 3,
                ),
              ),
              SizedBox(width: size.width * 0.01),
              CustomLabelStatus(
                width: size.width * 0.3,
                height: size.height * 0.04,
                content: product.status.toStatusTypeEnum().type,
                size: AssetsConstants.defaultFontSize - 18.0,
                backgroundColor:
                    getBackgrounStatusColor(product.status.toStatusTypeEnum()),
                contentColor:
                    getContentStatusColor(product.status.toStatusTypeEnum()),
              )
            ],
          ),
          SizedBox(height: size.height * 0.01),
          ContentBox(label: 'Mã:', content: product.code),
          SizedBox(height: size.height * 0.01),
          ContentBox(
              label: 'Loại:',
              content: 'Sản phẩm ${getTitleProductType(product.type)}'),
          SizedBox(height: size.height * 0.01),
          ContentBox(label: 'Danh mục:', content: product.categoryName),
          SizedBox(height: size.height * 0.01),
          ContentBox(label: 'Thương hiệu:', content: product.brand.name),
          SizedBox(height: size.height * 0.01),
          ContentBox(
            label: 'Giá bán:',
            content: getCustomContent({'Giá bán:': product.sellingPrice}),
          ),
          SizedBox(height: size.height * 0.01),
          ContentBox(
            label: 'Giá giảm giá:',
            content: getCustomContent({'Giá giảm giá:': product.discountPrice}),
          ),
          SizedBox(height: size.height * 0.01),
          ContentBox(
            label: 'Giá cũ:',
            content: getCustomContent({'Giá cũ:': product.historicalPrice}),
          ),
          if (product.size != null && product.size!.isNotEmpty) ...[
            SizedBox(height: size.height * 0.01),
            ContentBox(
              label: 'Kích cỡ:',
              content: 'Size ${product.size!}',
            ),
          ],
          SizedBox(height: size.height * 0.01),
          const LabelText(
            content: 'Mô tả:',
            size: AssetsConstants.defaultFontSize - 12.0,
            color: AssetsConstants.skipText,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: size.height * 0.01),
          LabelText(
            content: product.description,
            size: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.w600,
          ),
          const LinearHorizontal(),
          SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }
}
