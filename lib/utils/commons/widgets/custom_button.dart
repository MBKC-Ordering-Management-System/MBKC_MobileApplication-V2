import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import 'label_text.dart';

class CustomButton extends StatelessWidget {
  final String content;
  final bool isActive;
  final VoidCallback onCallback;
  final double width;
  final double height;
  final double size;
  final Color backgroundColor;
  const CustomButton({
    super.key,
    required this.content,
    required this.onCallback,
    required this.isActive,
    required this.width,
    required this.height,
    this.size = AssetsConstants.defaultFontSize - 5.0,
    this.backgroundColor = AssetsConstants.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive == true ? onCallback : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: LabelText(
            content: content.toUpperCase(),
            size: size,
            fontWeight: FontWeight.w700,
            color: AssetsConstants.whiteColor,
          ),
        ),
      ),
    );
  }
}
