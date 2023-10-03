import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

class FieldBox extends StatelessWidget {
  const FieldBox({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    // inti
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 1,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AssetsConstants.borderColor,
          ),
        ),
      ),
      padding:
          const EdgeInsets.only(bottom: AssetsConstants.defaultPadding - 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelText(
            content: title,
            size: AssetsConstants.defaultFontSize - 12.0,
            color: AssetsConstants.skipText,
          ),
          SizedBox(height: size.height * 0.01),
          LabelText(
            content: content,
            size: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
