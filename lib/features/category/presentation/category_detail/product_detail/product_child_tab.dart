import 'package:flutter/material.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../domain/models/product_model.dart';
import '../product_list/product_item.dart';

class ProductChildTab extends StatelessWidget {
  const ProductChildTab({super.key, required this.productsChild});
  final List<ProductModel> productsChild;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: productsChild.isEmpty
          ? const Align(
              alignment: Alignment.topCenter,
              child: EmptyBox(title: 'Không có sản phẩm'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: productsChild.length,
              itemBuilder: (_, index) => ProductItem(
                product: productsChild[index],
              ),
            ),
    );
  }
}
