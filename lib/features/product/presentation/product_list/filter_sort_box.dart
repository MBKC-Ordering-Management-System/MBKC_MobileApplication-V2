import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';

class FilterSortBox extends StatelessWidget {
  const FilterSortBox({
    super.key,
    required this.content,
  });
  final String content;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.28,
      height: size.height * 0.04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AssetsConstants.defaultBorder + 10.0,
        ),
        border: Border.all(
          color: AssetsConstants.mainColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AssetsConstants.defaultPadding - 14.0,
            ),
            child: LabelText(
              content: content,
              size: AssetsConstants.defaultFontSize - 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AssetsConstants.blackColor,
            size: AssetsConstants.defaultFontSize - 4.0,
          )
        ],
      ),
    );
  }
}
