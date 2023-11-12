import 'package:flutter/material.dart';
import 'widgets_common_export.dart';
import '../../constants/asset_constant.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({super.key, required this.label, required this.content});
  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    // intit
    final size = MediaQuery.sizeOf(context);

    return Row(
      children: [
        LabelText(
          content: label,
          size: AssetsConstants.defaultFontSize - 12.0,
          color: AssetsConstants.skipText,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(width: size.width * 0.02),
        Expanded(
          child: LabelText(
            content: content,
            size: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.w600,
            maxLine: 5,
          ),
        ),
      ],
    );
  }
}
