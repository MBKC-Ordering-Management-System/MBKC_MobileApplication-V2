import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../domain/models/product_model.dart';
import '../product_list/product_item.dart';

class ProductExtraTab extends StatelessWidget {
  const ProductExtraTab({super.key, required this.productsExtra});
  final List<ProductModel> productsExtra;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: productsExtra.isEmpty
          ? const Align(
              alignment: Alignment.topCenter,
              child: EmptyBox(title: 'Không có sản phẩm'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: productsExtra.length,
              itemBuilder: (_, index) => ProductItem(
                product: productsExtra[index],
              ),
            ),
    );
  }
}
