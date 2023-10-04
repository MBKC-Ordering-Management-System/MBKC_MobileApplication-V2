import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import 'label_text.dart';
import 'search_time_box.dart';

showCustomBottomSheet({
  required BuildContext context,
  required Size size,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AssetsConstants.defaultPadding - 10.0,
        ),
        height: size.height * 0.5,
        width: size.width * 1,
        decoration: const BoxDecoration(
          color: AssetsConstants.scaffoldColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AssetsConstants.defaultBorder + 10.0),
            topRight: Radius.circular(AssetsConstants.defaultBorder + 10.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.filter_alt_rounded,
                      color: AssetsConstants.blackColor,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    const LabelText(
                      content: 'Lọc',
                      size: AssetsConstants.defaultFontSize - 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => context.router.pop(),
                  icon: const Icon(
                    Icons.close,
                    color: AssetsConstants.blackColor,
                  ),
                )
              ],
            ),
            const SearchTimeBox(
              borderColor: AssetsConstants.borderColor,
              title: 'Tra cứu đơn hàng',
              icon: Icons.shopping_bag_rounded,
              contentColor: AssetsConstants.blackColor,
              backGroundColor: AssetsConstants.whiteColor,
            ),
          ],
        ),
      );
    },
  );
}
