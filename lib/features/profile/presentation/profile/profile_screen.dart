import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../../auth/presentation/enter_email/enter_email_controller.dart';
import '../../../auth/presentation/sign_in/sign_in_controller.dart';
import '../../domain/models/profile_model.dart';
import 'action_box.dart';
import 'profile_box.dart';
import 'profile_controller.dart';

@RoutePage()
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  // fetch data
  Future<void> fetchData({
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<ProfileModel?> profile,
  }) async {
    final profileData =
        await ref.read(profileControllerProvider.notifier).getProfile(context);

    profile.value = profileData;
  }

  // confirm email
  void checkEmail({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
  }) async {
    await ref.read(enterEmailControllerProvider.notifier).checkEmail(
          email: email,
          context: context,
          type: VerificationOTPType.changepassword,
        );
  }

  // sign out
  void signOut({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final result = await showAlertDialog(
      context: context,
      title: 'Xác nhận',
      content: 'Bạn có muốn đăng xuất ?',
      cancelActionText: 'Hủy',
    );
    if (result != null && result) {
      ref.read(signInControllerProvider.notifier).signOut(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final profile = useState<ProfileModel?>(null);
    final state = ref.watch(profileControllerProvider);

    // first build
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchData(ref: ref, context: context, profile: profile);
      });

      return null;
    }, const []);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tài Khoản',
      ),
      body: state.isLoading
          ? const HomeShimmer(amount: 3)
          : profile.value == null
              ? const EmptyBox(title: 'Sai thông tin')
              : Column(
                  children: [
                    ProfileBox(profile: profile.value!),
                    InkWell(
                      onTap: () =>
                          context.router.push(const WalletScreenRoute()),
                      child: const ActionBox(
                        icon: FontAwesomeIcons.wallet,
                        title: 'Ví',
                        color: AssetsConstants.blackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          context.router.push(const PartnerScreenRoute()),
                      child: const ActionBox(
                        icon: FontAwesomeIcons.handshakeAngle,
                        title: 'Đối tác',
                        color: AssetsConstants.blackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final user = ref.read(authProvider);
                        checkEmail(
                          context: context,
                          ref: ref,
                          email: user!.email,
                        );
                      },
                      child: const ActionBox(
                        icon: Icons.lock,
                        title: 'Thay đổi mật khẩu',
                        color: AssetsConstants.blackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () => signOut(context: context, ref: ref),
                      child: const ActionBox(
                        icon: FontAwesomeIcons.rightFromBracket,
                        title: 'Đăng xuất',
                        color: AssetsConstants.warningColor,
                      ),
                    ),
                  ],
                ),
    );
  }
}
