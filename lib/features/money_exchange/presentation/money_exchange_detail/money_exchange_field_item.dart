import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';

class MoneyExchangeFieldItem extends StatelessWidget {
  const MoneyExchangeFieldItem({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    // init
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelText(
            content: title,
            size: AssetsConstants.defaultFontSize - 10.0,
            color: AssetsConstants.skipText,
          ),
          SizedBox(height: size.height * 0.01),
          LabelText(
            content: content,
            size: AssetsConstants.defaultFontSize - 10.0,
            maxLine: 10,
          ),
          SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }
}
