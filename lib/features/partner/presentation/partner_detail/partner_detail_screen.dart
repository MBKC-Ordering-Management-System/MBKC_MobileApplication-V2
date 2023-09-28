import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/app_bar.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../domain/models/partner_model.dart';
import 'information_box.dart';
import 'partner_box.dart';

@RoutePage()
class PartnerDetailScreen extends StatelessWidget {
  const PartnerDetailScreen({
    super.key,
    required this.partner,
  });
  final PartnerModel partner;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tài khoản đối tác',
        backButtonColor: AssetsConstants.whiteColor,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(
            top: AssetsConstants.defaultMargin + 10.0,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AssetsConstants.defaultPadding - 6.0,
            vertical: AssetsConstants.defaultPadding,
          ),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(color: AssetsConstants.subtitleColor),
            borderRadius: BorderRadius.circular(10),
            color: AssetsConstants.whiteColor,
          ),
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelText(
                  content: 'Đối tác',
                  size: AssetsConstants.defaultFontSize - 8.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.02),
                PartnerBox(
                  type: partner.type,
                ),
                SizedBox(height: size.height * 0.02),
                const LabelText(
                  content: 'Tài khoản',
                  size: AssetsConstants.defaultFontSize - 8.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.02),
                InformationBox(
                  isPassword: false,
                  type: partner.type,
                  content: partner.username,
                ),
                SizedBox(height: size.height * 0.02),
                const LabelText(
                  content: 'Mật khẩu',
                  size: AssetsConstants.defaultFontSize - 8.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.02),
                InformationBox(
                  isPassword: true,
                  type: partner.type,
                  content: partner.password,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
