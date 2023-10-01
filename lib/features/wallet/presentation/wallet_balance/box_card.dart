import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

class BoxCard extends StatelessWidget {
  final Color backgroundColor;
  final Color contentColor;
  final IconData icon;
  final String content;
  const BoxCard({
    super.key,
    required this.backgroundColor,
    required this.contentColor,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 0.44,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: contentColor,
          ),
          LabelText(
            content: content,
            size: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.w600,
            color: contentColor,
          ),
        ],
      ),
    );
  }
}
