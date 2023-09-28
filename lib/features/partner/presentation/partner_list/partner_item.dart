import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/partner_model.dart';

class PartnerItem extends StatelessWidget {
  const PartnerItem({super.key, required this.partner});
  final PartnerModel partner;

  @override
  Widget build(BuildContext context) {
    // init
    // final size = MediaQuery.sizeOf(context);

    return Container(
      margin: const EdgeInsets.only(
        bottom: AssetsConstants.defaultMargin - 2.0,
      ),
      child: ListTile(
        leading: Image.asset(
          partner.type == PartnerType.grabfood
              ? AssetsConstants.grabLogo
              : partner.type == PartnerType.shopeefood
                  ? AssetsConstants.shopeeLogo
                  : AssetsConstants.beaminLogo,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: AssetsConstants.subtitleColor,
          ),
        ),
        title: LabelText(
          content: partner.type == PartnerType.grabfood
              ? 'GrabFood'
              : partner.type == PartnerType.shopeefood
                  ? 'ShopeeFood'
                  : 'Beamin',
          size: AssetsConstants.defaultFontSize - 12.0,
          fontWeight: FontWeight.bold,
        ),
        subtitle: LabelText(
          content: partner.username,
          size: AssetsConstants.defaultFontSize - 14.0,
          fontWeight: FontWeight.w600,
        ),
        trailing: const Icon(
          Icons.edit_square,
          color: AssetsConstants.blackColor,
          size: AssetsConstants.defaultFontSize - 6.0,
        ),
      ),
    );
  }
}
