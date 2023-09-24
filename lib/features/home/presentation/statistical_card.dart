import 'package:flutter/material.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';

class StatisticalCard extends StatelessWidget {
  const StatisticalCard({
    super.key,
    required this.backgroundColor,
    required this.contentColor,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Color backgroundColor;
  final Color contentColor;
  final Icon icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AssetsConstants.defaultPadding,
      ),
      width: size.width * 0.9,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: size.height * 0.01),
          LabelText(
            content: title,
            size: AssetsConstants.defaultFontSize - 8.0,
            color: contentColor,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: size.height * 0.01),
          LabelText(
            content: subtitle,
            size: AssetsConstants.defaultFontSize - 10.0,
            color: contentColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
