import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';

class PartnerBox extends StatelessWidget {
  const PartnerBox({super.key, required this.type});
  final PartnerType type;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorPartner = getColorPartner(type);

    return Container(
      width: size.width * 1,
      decoration: BoxDecoration(
        color: colorPartner,
        borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
            child: Image.asset(
              getLogoPartner(type),
              width: size.width * 0.16,
            ),
          ),
          SizedBox(width: size.width * 0.25),
          LabelText(
            content: getTitlePartner(type),
            size: AssetsConstants.defaultFontSize - 10.0,
            color: AssetsConstants.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
