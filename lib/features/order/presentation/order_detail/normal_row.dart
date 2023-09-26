import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

class NormalRow extends StatelessWidget {
  const NormalRow({super.key, required this.content});
  final List<Map<String, dynamic>> content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AssetsConstants.defaultPadding - 15.0,
        horizontal: AssetsConstants.defaultPadding - 10.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AssetsConstants.borderColor),
        ),
      ),
      child: Column(
        children: [
          ...content.map(
            (e) => Container(
              margin: const EdgeInsets.symmetric(
                vertical: AssetsConstants.defaultMargin - 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: LabelText(
                        content: e.entries.first.key,
                        size: AssetsConstants.defaultFontSize - 13.0,
                        fontWeight: FontWeight.w600,
                        maxLine: 2,
                        color: e.entries.first.key == 'Giảm giá:'
                            ? AssetsConstants.discountColor
                            : AssetsConstants.blackColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: LabelText(
                        content: getCustomContent(e),
                        size: AssetsConstants.defaultFontSize - 13.0,
                        fontWeight: e.entries.first.key == 'Tổng cộng:'
                            ? FontWeight.bold
                            : FontWeight.w600,
                        maxLine: 10,
                        color: e.entries.first.key == 'Giảm giá:'
                            ? AssetsConstants.discountColor
                            : AssetsConstants.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
