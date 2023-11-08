import 'package:flutter/material.dart';
import '../../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
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
        children: [
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Mã sản phẩm', content: product.code),
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Tên sản phẩm', content: product.name),
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Mô tả', content: product.description),
          SizedBox(height: size.height * 0.01),
          FieldBox(
            title: 'Giá bán',
            content: getCustomContent({'Giá bán': product.sellingPrice}),
          ),
          SizedBox(height: size.height * 0.01),
          FieldBox(
            title: 'Giá giảm giá',
            content: getCustomContent({'Giá giảm giá': product.discountPrice}),
          ),
          SizedBox(height: size.height * 0.01),
          FieldBox(
            title: 'Giá cũ',
            content: getCustomContent({'Giá cũ': product.historicalPrice}),
          ),
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Loại', content: getTitleProductType(product.type)),
          if (product.size != null && product.size!.isNotEmpty) ...[
            SizedBox(height: size.height * 0.01),
            FieldBox(
              title: 'Kích cỡ',
              content: product.size!,
            ),
          ],
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Danh mục', content: product.categoryName),
          SizedBox(height: size.height * 0.01),
          FieldBox(title: 'Thương hiệu', content: product.brand.name),
        ],
      ),
    );
  }
}
