import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../functions/functions_common_export.dart';
import 'widgets_common_export.dart';
import '../../constants/asset_constant.dart';

class SearchTimeBox extends HookConsumerWidget {
  const SearchTimeBox({
    super.key,
    required this.title,
    required this.icon,
    required this.contentColor,
    required this.backGroundColor,
    required this.borderColor,
  });
  final String title;
  final Color contentColor;
  final Color backGroundColor;
  final Color borderColor;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final dateFrom = useState(getDateTimeNow());
    final dateTo = useState(getDateTimeNow());

    return Container(
      width: size.width * 1,
      height: size.height * 0.15,
      padding: const EdgeInsets.symmetric(
        horizontal: AssetsConstants.defaultPadding - 6.0,
        vertical: AssetsConstants.defaultPadding - 15.0,
      ),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: contentColor),
              SizedBox(width: size.width * 0.05),
              LabelText(
                content: title,
                size: AssetsConstants.defaultFontSize - 10.0,
                color: contentColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Container(
            height: 1,
            decoration: BoxDecoration(
              border: Border.all(
                color: contentColor,
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
                  LabelText(
                    content: 'Từ ngày',
                    size: AssetsConstants.defaultFontSize - 10.0,
                    color: contentColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      LabelText(
                        content: dateFrom.value,
                        size: AssetsConstants.defaultFontSize - 10.0,
                        color: contentColor,
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(
                    content: 'Đến ngày',
                    size: AssetsConstants.defaultFontSize - 10.0,
                    color: contentColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      LabelText(
                        content: dateTo.value,
                        size: AssetsConstants.defaultFontSize - 10.0,
                        color: contentColor,
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: contentColor,
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
