import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../configs/routes/app_router.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';
import 'action_box.dart';

@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tài Khoản',
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AssetsConstants.defaultPadding - 10.0,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AssetsConstants.borderColor),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AssetsConstants.defaultPadding - 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: size.height * 0.115,
                    width: size.width * 0.21,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        AssetsConstants.avatarXB,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const LabelText(
                    content: 'Bếp Xuân Bách',
                    size: AssetsConstants.defaultFontSize - 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AssetsConstants.subtitleColor,
                  ),
                ],
              ),
            ),
          ),
          const ActionBox(
            icon: FontAwesomeIcons.wallet,
            title: 'Ví',
            color: AssetsConstants.blackColor,
          ),
          InkWell(
            onTap: () {
              context.router.push(const PartnerScreenRoute());
            },
            child: const ActionBox(
              icon: FontAwesomeIcons.handshakeAngle,
              title: 'Đối tác',
              color: AssetsConstants.blackColor,
            ),
          ),
          const ActionBox(
            icon: Icons.lock,
            title: 'Thay đổi mật khẩu',
            color: AssetsConstants.blackColor,
          ),
          const ActionBox(
            icon: FontAwesomeIcons.rightFromBracket,
            title: 'Đăng xuất',
            color: AssetsConstants.warningColor,
          ),
        ],
      ),
    );
  }
}
