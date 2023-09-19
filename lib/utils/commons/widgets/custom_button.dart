import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import 'label_text.dart';

class CustomButton extends StatelessWidget {
  final String content;
  final bool isActive;
  final VoidCallback onCallback;
  const CustomButton({
    super.key,
    required this.content,
    required this.onCallback,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: isActive == true ? onCallback : null,
      child: Container(
        width: size.width * 0.95,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: isActive == true
              ? AssetsConstants.mainColor
              : AssetsConstants.subtitleColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: LabelText(
            content: content.toUpperCase(),
            size: AssetsConstants.defaultFontSize - 5.0,
            fontWeight: FontWeight.w700,
            color: AssetsConstants.whiteColor,
          ),
        ),
      ),
    );
  }
}
