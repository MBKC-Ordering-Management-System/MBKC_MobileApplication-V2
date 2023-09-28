import 'package:flutter/material.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';

class ActionBox extends StatelessWidget {
  const ActionBox({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });
  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AssetsConstants.defaultPadding - 8.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AssetsConstants.borderColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AssetsConstants.defaultPadding + 10.0,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  icon,
                  size: AssetsConstants.defaultFontSize - 8.0,
                  color: color,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              child: LabelText(
                content: title,
                size: AssetsConstants.defaultFontSize - 10.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
