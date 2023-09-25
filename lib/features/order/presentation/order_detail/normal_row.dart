import 'package:flutter/material.dart';
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
        horizontal: AssetsConstants.defaultPadding - 5.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AssetsConstants.borderColor),
        ),
      ),
      child: Column(
        children: [
          ...content.map(
            (e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelText(
                  content: e.entries.first.key,
                  size: AssetsConstants.defaultFontSize - 13.0,
                  fontWeight: FontWeight.w600,
                  maxLine: 2,
                  color: e.entries.first.key == 'Giảm giá'
                      ? AssetsConstants.warningColor
                      : AssetsConstants.blackColor,
                ),
                LabelText(
                  content: e.entries.first.value,
                  size: AssetsConstants.defaultFontSize - 13.0,
                  fontWeight: FontWeight.w600,
                  maxLine: 2,
                  color: e.entries.first.key == 'Giảm giá'
                      ? AssetsConstants.warningColor
                      : AssetsConstants.blackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
