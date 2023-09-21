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
  const CustomButton({
    super.key,
    required this.content,
    required this.onCallback,
    required this.isActive,
    required this.width,
    required this.height,
    this.size = AssetsConstants.defaultFontSize - 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive == true ? onCallback : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isActive == true
              ? AssetsConstants.mainColor
              : AssetsConstants.subtitleColor,
          borderRadius: BorderRadius.circular(10),
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
