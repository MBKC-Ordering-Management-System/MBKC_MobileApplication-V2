import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets_common_export.dart';
import '../../constants/asset_constant.dart';

class StatisticalCard extends StatelessWidget {
  const StatisticalCard({
    super.key,
    required this.backgroundColor,
    required this.contentColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.state,
    required this.loadingColor,
  });

  final Color backgroundColor;
  final Color contentColor;
  final Color loadingColor;
  final Icon icon;
  final String title;
  final String subtitle;
  final AsyncValue<void> state;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AssetsConstants.defaultPadding,
      ),
      width: size.width * 1,
      height: size.height * 0.12,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.isLoading)
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                color: loadingColor,
              ),
            ),
          if (state.isLoading == false) ...[
            icon,
            SizedBox(height: size.height * 0.01),
            LabelText(
              content: title,
              size: AssetsConstants.defaultFontSize - 10.0,
              color: contentColor,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: size.height * 0.01),
            LabelText(
              content: subtitle,
              size: AssetsConstants.defaultFontSize - 12.0,
              color: contentColor,
              fontWeight: FontWeight.w600,
            ),
          ]
        ],
      ),
    );
  }
}
