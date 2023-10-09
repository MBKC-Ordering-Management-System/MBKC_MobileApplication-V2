import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/models/product_model.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AssetsConstants.defaultPadding - 10.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AssetsConstants.borderColor),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: size.height * 0.11,
            width: size.width * 0.21,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AssetsConstants.defaultBorder,
              ),
              child: product.image.isEmpty
                  ? Image.asset(AssetsConstants.defaultAvatar)
                  : FadeInImage(
                      placeholder:
                          const AssetImage(AssetsConstants.welcomeImage),
                      image: NetworkImage(product.image),
                    ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.verified,
                      color: AssetsConstants.mainColor,
                      size: AssetsConstants.defaultFontSize - 12.0,
                    ),
                    SizedBox(width: size.width * 0.01),
                    Expanded(
                      child: LabelText(
                        content: product.name,
                        size: AssetsConstants.defaultFontSize - 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                LabelText(
                  content: product.description,
                  size: AssetsConstants.defaultFontSize - 12.0,
                  color: AssetsConstants.descriptionColor,
                ),
                SizedBox(height: size.height * 0.01),
                LabelText(
                  content:
                      '${NumberFormat.decimalPattern().format(product.sellingPrice)}đ',
                  size: AssetsConstants.defaultFontSize - 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
