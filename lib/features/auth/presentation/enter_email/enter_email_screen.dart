import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../sign_in/sign_in_validator.dart';
import 'enter_email_controller.dart';

@RoutePage()
class EnterEmailScreen extends HookConsumerWidget with SignInValidators {
  EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final email = useTextEditingController();
    final state = ref.watch(enterEmailControllerProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);

    // handle error
    ref.listen<AsyncValue>(
      enterEmailControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    // submit
    void submit() async {
      if (formKey.currentState!.validate()) {
        await ref.read(enterEmailControllerProvider.notifier).checkEmail(
              email: email.text.trim(),
              context: context,
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
                    onValidate: (val) => emailErrorText(val),
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
              onCallback: submit,
              size: AssetsConstants.defaultFontSize - 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
