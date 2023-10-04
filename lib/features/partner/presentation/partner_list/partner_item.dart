import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/modify_type.dart';
import '../../domain/models/partner_model.dart';

class PartnerItem extends StatelessWidget {
  const PartnerItem({
    super.key,
    required this.partner,
    required this.partners,
    required this.isRefresh,
  });
  final PartnerModel partner;
  final ValueNotifier<List<PartnerModel>> partners;
  final ValueNotifier<bool> isRefresh;

  // on delete
  void deletePartner({
    required BuildContext context,
  }) {
    partners.value.removeWhere((item) => item.id == partner.id);

    showSnackBar(
      context: context,
      content: 'Xóa thành công',
      icon: AssetsConstants.iconSuccess,
      backgroundColor: AssetsConstants.mainColor,
      textColor: AssetsConstants.whiteColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    // init
    // final size = MediaQuery.sizeOf(context);

    return Dismissible(
      confirmDismiss: (DismissDirection direction) async =>
          await showAlertDialog(
        context: context,
        title: 'Xác nhận',
        content: 'Bạn chắc chứ',
        cancelActionText: 'Hủy',
      ),
      onDismissed: (_) => deletePartner(context: context),
      background: Container(
        padding: const EdgeInsets.only(
          right: AssetsConstants.defaultPadding - 10.0,
        ),
        margin: const EdgeInsets.only(
          bottom: AssetsConstants.defaultMargin - 2.0,
        ),
        decoration: BoxDecoration(
          color: AssetsConstants.warningColor,
          borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey(partner.id),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: AssetsConstants.defaultMargin - 2.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AssetsConstants.subtitleColor,
          ),
          borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
        ),
        child: ListTile(
          onTap: () {
            context.router.push(PartnerDetailScreenRoute(partner: partner));
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
            child: Image.asset(getLogoPartner(partner.type)),
          ),
          title: LabelText(
            content: getTitlePartner(partner.type),
            size: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.bold,
          ),
          subtitle: LabelText(
            content: partner.username,
            size: AssetsConstants.defaultFontSize - 14.0,
            fontWeight: FontWeight.w600,
          ),
          trailing: IconButton(
            onPressed: () {
              context.router
                  .push(
                PartnerModifyScreenRoute(
                  type: ModifyType.update,
                  partner: partner,
                ),
              )
                  .then((value) {
                if (value != null && value == true) {
                  isRefresh.value = !isRefresh.value;
                }
              });
            },
            icon: const Icon(
              Icons.edit_square,
              color: AssetsConstants.blackColor,
              size: AssetsConstants.defaultFontSize - 6.0,
            ),
          ),
        ),
      ),
    );
  }
}
