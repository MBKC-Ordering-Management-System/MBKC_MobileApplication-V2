import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

class TransactionSearchBox extends StatelessWidget {
  const TransactionSearchBox({
    super.key,
    required this.from,
    required this.to,
  });
  final ValueNotifier<String> from;
  final ValueNotifier<String> to;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 1,
      height: size.height * 0.15,
      padding: const EdgeInsets.symmetric(
        horizontal: AssetsConstants.defaultPadding - 6.0,
        vertical: AssetsConstants.defaultPadding - 15.0,
      ),
      decoration: BoxDecoration(
        color: AssetsConstants.mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.insert_chart_outlined),
              SizedBox(width: size.width * 0.05),
              const LabelText(
                content: 'Tra cứu giao dịch',
                size: AssetsConstants.defaultFontSize - 10.0,
                color: AssetsConstants.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Container(
            height: 1,
            decoration: BoxDecoration(
              border: Border.all(
                color: AssetsConstants.whiteColor,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelText(
                    content: 'Từ ngày',
                    size: AssetsConstants.defaultFontSize - 10.0,
                    color: AssetsConstants.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      LabelText(
                        content: from.value,
                        size: AssetsConstants.defaultFontSize - 10.0,
                        color: AssetsConstants.whiteColor,
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelText(
                    content: 'Đến ngày',
                    size: AssetsConstants.defaultFontSize - 10.0,
                    color: AssetsConstants.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      LabelText(
                        content: to.value,
                        size: AssetsConstants.defaultFontSize - 10.0,
                        color: AssetsConstants.whiteColor,
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: AssetsConstants.whiteColor,
                  size: AssetsConstants.defaultFontSize - 6.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
