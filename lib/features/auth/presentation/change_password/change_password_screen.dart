import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/password_input.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final newPassword = useTextEditingController();
    final comfirmPassword = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final state = ref.watch(changePasswordControllerProvider);

    // handle error
    ref.listen<AsyncValue>(
      changePasswordControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    // submit
    void submit() async {
      if (formKey.currentState!.validate()) {
        await ref
            .read(changePasswordControllerProvider.notifier)
            .changePassword(
              email: email,
              password: newPassword.text.trim(),
              context: context,
              verifyType: verifyType,
            );
      }
    }

    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        backgroundColor: AssetsConstants.whiteColor,
        appBar: const CustomeAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AssetsConstants.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.001),
                const LabelText(
                  content: 'Đổi mật khẩu mới',
                  size: AssetsConstants.defaultFontSize - 5.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.02),
                const LabelText(
                  content: 'Hãy cẩn trọng hơn trong việc ghi nhớ mật khẩu',
                  size: AssetsConstants.defaultFontSize - 9.0,
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
          margin: EdgeInsets.only(bottom: size.height * 0.06),
          padding: const EdgeInsets.only(
            right: AssetsConstants.defaultPadding,
            left: AssetsConstants.defaultPadding,
          ),
          child: ValueListenableBuilder2(
            first: newPassword,
            second: comfirmPassword,
            builder: (_, a, b, __) => CustomButton(
              content: 'Xác nhận',
              onCallback: submit,
              isActive: a.text.isNotEmpty && b.text.isNotEmpty,
            ),
          ),
        ),
      ),
    );
  }
}
