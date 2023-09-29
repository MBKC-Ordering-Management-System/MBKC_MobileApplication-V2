import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';

class PartnerItemPick extends StatelessWidget {
  const PartnerItemPick({
    super.key,
    required this.partnerTypeDynamic,
    required this.partnerTypeStatic,
    required this.size,
    required this.isLast,
  });

  final ValueNotifier<PartnerType> partnerTypeDynamic;
  final PartnerType partnerTypeStatic;
  final Size size;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AssetsConstants.defaultPadding - 12.0,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? const Border()
            : const Border(
                bottom: BorderSide(
                  color: AssetsConstants.borderColor,
                ),
              ),
      ),
      child: ListTile(
        visualDensity:
            const VisualDensity(vertical: AssetsConstants.defaultFontSize - 29),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            getLogoPartner(partnerTypeStatic),
            height: size.height * 0.1,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(
            left: AssetsConstants.defaultPadding,
          ),
          child: LabelText(
            content: getTitlePartner(partnerTypeStatic),
            size: AssetsConstants.defaultFontSize - 9.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.check,
          color: partnerTypeDynamic.value == partnerTypeStatic
              ? AssetsConstants.mainColor
              : AssetsConstants.whiteColor,
        ),
      ),
    );
  }
}
