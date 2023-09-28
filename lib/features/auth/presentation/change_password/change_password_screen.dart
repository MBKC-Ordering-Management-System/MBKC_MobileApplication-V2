import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../sign_in/sign_in_validator.dart';
import 'change_password_controller.dart';

@RoutePage()
class ChangePasswordScreen extends HookConsumerWidget with SignInValidators {
  ChangePasswordScreen({
    super.key,
    required this.email,
    required this.verifyType,
  });
  final String email;
  final VerificationOTPType verifyType;

  // handle submit
  void submit({
    required WidgetRef ref,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String password,
  }) async {
    if (formKey.currentState!.validate()) {
      await ref.read(changePasswordControllerProvider.notifier).changePassword(
            email: email,
            password: password,
            context: context,
            verifyType: verifyType,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final newPassword = useTextEditingController();
    final comfirmPassword = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final state = ref.watch(changePasswordControllerProvider);

    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        backgroundColor: AssetsConstants.whiteColor,
        appBar: const CustomAppBar(
          backgroundColor: AssetsConstants.whiteColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AssetsConstants.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelText(
                  content: 'Đổi mật khẩu mới',
                  size: AssetsConstants.defaultFontSize - 8.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.02),
                const LabelText(
                  content: 'Hãy cẩn trọng hơn khi ghi nhớ mật khẩu',
                  size: AssetsConstants.defaultFontSize - 11.0,
                  fontWeight: FontWeight.w700,
                  color: AssetsConstants.subtitleColorM,
                ),
                SizedBox(height: size.height * 0.02),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      PasswordInput(
                        textEditingController: newPassword,
                        hintText: 'Mật khẩu',
                        onValidate: (val) => passwordErrorText(val),
                        autoFocus: true,
                      ),
                      SizedBox(height: size.height * 0.02),
                      PasswordInput(
                        textEditingController: comfirmPassword,
                        hintText: 'Nhập lại mật khẩu',
                        onValidate: (val) {
                          var error = '';
                          error = passwordErrorText(val);
                          if (newPassword.text.length >= 8 &&
                              comfirmPassword.text.length >= 8) {
                            error = passwordEqualErrorText(
                              newPassword.text.trim(),
                              comfirmPassword.text.trim(),
                            );
                          }

                          return error;
                        },
                        autoFocus: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: size.height * 0.04),
          padding: const EdgeInsets.only(
            right: AssetsConstants.defaultPadding,
            left: AssetsConstants.defaultPadding,
          ),
          child: ValueListenableBuilder2(
            first: newPassword,
            second: comfirmPassword,
            builder: (_, a, b, __) => CustomButton(
              width: size.width * 1,
              height: size.height * 0.05,
              content: 'Xác nhận',
              onCallback: () => submit(
                ref: ref,
                context: context,
                formKey: formKey,
                password: newPassword.text.trim(),
              ),
              isActive: a.text.isNotEmpty && b.text.isNotEmpty,
              size: AssetsConstants.defaultFontSize - 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
