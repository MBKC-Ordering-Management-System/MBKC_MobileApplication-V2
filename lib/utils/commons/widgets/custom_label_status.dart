import 'package:flutter/material.dart';
import 'label_text.dart';

class CustomLabelStatus extends StatelessWidget {
  const CustomLabelStatus({
    super.key,
    required this.width,
    required this.height,
    required this.content,
    required this.size,
    required this.backgroundColor,
    required this.contentColor,
  });
  final double width;
  final double height;
  final String content;
  final double size;
  final Color backgroundColor;
  final Color contentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        child: LabelText(
          content: content.toUpperCase(),
          size: size,
          color: contentColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
