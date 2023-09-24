import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/widgets/app_bar.dart';
import '../../../../utils/commons/widgets/custom_button.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/commons/widgets/loading_overlay.dart';
import '../../../../utils/commons/widgets/password_input.dart';
import '../../../../utils/commons/widgets/text_input.dart';
import '../../../../utils/commons/widgets/value_listenable_builder.dart';
import '../../../../utils/constants/asset_constant.dart';
import 'sign_in_controller.dart';
import 'sign_in_validator.dart';

@RoutePage()
class SignInScreen extends HookConsumerWidget with SignInValidators {
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final username = useTextEditingController(text: 'mbkcadminn@gmail.com');
    final password = useTextEditingController(text: '12345678');
    final state = ref.watch(signInControllerProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);

    // unfocus
    void unfocus() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    // handle submit
    void submit() async {
      unfocus();
      if (formKey.currentState!.validate()) {
        await ref.read(signInControllerProvider.notifier).login(
              username.text.trim(),
              password.text.trim(),
              context,
            );
      }
    }

    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.2),
          child: Stack(
            children: [
              const CustomeAppBar(backgroundColor: AssetsConstants.mainColor),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  AssetsConstants.welcomeImage,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            right: AssetsConstants.defaultPadding,
            left: AssetsConstants.defaultPadding,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.02),
                  LabelText(
                    content: 'Chào mừng bạn đến với MBKC'.toUpperCase(),
                    size: AssetsConstants.defaultFontSize - 8.0,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: size.height * 0.01),
                  const LabelText(
                    content: 'Hãy nhập tài khoản để tiếp tục',
                    size: AssetsConstants.defaultFontSize - 11.0,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInput(
                          textController: username,
                          hintText: 'Tài khoản',
                          onValidate: (val) => emailErrorText(val),
                          autoFocus: true,
                        ),
                        SizedBox(height: size.height * 0.02),
                        PasswordInput(
                          textEditingController: password,
                          hintText: 'Mật khẩu',
                          onValidate: (val) => passwordErrorText(val),
                          autoFocus: false,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            context.router.push(EnterEmailScreenRoute());
                          },
                          child: const LabelText(
                            content: 'Quên mật khẩu?',
                            size: AssetsConstants.defaultFontSize - 15.0,
                            fontWeight: FontWeight.w700,
                            color: AssetsConstants.subtitleColorM,
                            textDecoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
            first: username,
            second: password,
            builder: (_, a, b, __) => CustomButton(
              width: size.width * 1,
              height: size.height * 0.05,
              content: 'Đăng nhập',
              onCallback: submit,
              isActive: a.text.isNotEmpty && b.text.isNotEmpty,
              size: AssetsConstants.defaultFontSize - 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
