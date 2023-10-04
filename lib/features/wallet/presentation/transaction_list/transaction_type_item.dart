import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

class TransactionTypeItem extends StatelessWidget {
  const TransactionTypeItem({
    super.key,
    required this.title,
    required this.isActive,
  });
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 0.25,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: isActive
            ? AssetsConstants.revenueBackground
            : AssetsConstants.backgroundInactive,
        borderRadius: BorderRadius.circular(
          AssetsConstants.defaultBorder - 5.0,
        ),
      ),
      child: Center(
        child: LabelText(
          content: title,
          size: AssetsConstants.defaultFontSize - 12.0,
          fontWeight: FontWeight.w600,
          color:
              isActive ? AssetsConstants.mainColor : AssetsConstants.skipText,
        ),
      ),
    );
  }
}
