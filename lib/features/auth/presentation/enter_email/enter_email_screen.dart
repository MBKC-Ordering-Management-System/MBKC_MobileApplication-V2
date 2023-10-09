import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/verification_otp_type.dart';
import '../../../../utils/resources/validations.dart';
import 'enter_email_controller.dart';

@RoutePage()
class EnterEmailScreen extends HookConsumerWidget with Validations {
  EnterEmailScreen({super.key});

  // submit
  void submit({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String email,
  }) async {
    if (formKey.currentState!.validate()) {
      unfocus(context);
      await ref.read(enterEmailControllerProvider.notifier).checkEmail(
            email: email,
            context: context,
            type: VerificationOTPType.forgotpassword,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final email = useTextEditingController(text: 'thanhlhse150023@fpt.edu.vn');
    final state = ref.watch(enterEmailControllerProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);

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
                  content: 'Hãy nhập email mà bạn đã đăng kí',
                  size: AssetsConstants.defaultFontSize - 8.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.01),
                const LabelText(
                  content: 'MBKC sẽ gửi mã xác nhận đến email này',
                  size: AssetsConstants.defaultFontSize - 11.0,
                  fontWeight: FontWeight.w700,
                  color: AssetsConstants.subtitleColorM,
                ),
                SizedBox(height: size.height * 0.02),
                Form(
                  key: formKey,
                  child: TextInput(
                    textController: email,
                    hintText: 'Email',
                    onValidate: (val) => '',
                    autoFocus: true,
                  ),
                )
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
          child: ValueListenableBuilder1(
            first: email,
            builder: (_, a, __) => CustomButton(
              width: size.width * 1,
              height: size.height * 0.05,
              isActive: a.text.isNotEmpty,
              content: 'Tiếp Tục',
              onCallback: () => submit(
                formKey: formKey,
                context: context,
                ref: ref,
                email: email.text.trim(),
              ),
              size: AssetsConstants.defaultFontSize - 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
