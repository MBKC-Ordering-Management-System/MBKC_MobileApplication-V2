import 'package:flutter/material.dart';
import 'widgets_common_export.dart';
import '../../constants/asset_constant.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.content,
    required this.onCallback,
    required this.outlineColor,
    required this.backgroundColor,
    required this.textColor,
    required this.width,
    required this.height,
  });

  final String content;
  final VoidCallback onCallback;
  final Color outlineColor;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCallback,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: outlineColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: LabelText(
            content: content,
            size: AssetsConstants.defaultFontSize - 5.0,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
