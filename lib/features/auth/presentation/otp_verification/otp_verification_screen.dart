import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/async_value_ui.dart';
import 'otp_field.dart';
import 'otp_verification_controller.dart';

@RoutePage()
class OTPVerificationScreen extends HookConsumerWidget {
  final VerificationOTPType verifyType;
  final String email;
  const OTPVerificationScreen({
    super.key,
    required this.email,
    required this.verifyType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final timer = useState<Timer?>(null);
    final start = useState(10);
    final wait = useState(true);
    final state = ref.watch(otpVerificationControllerProvider);

    // handle error
    ref.listen<AsyncValue>(
      otpVerificationControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    // text controller
    final otp_1 = useTextEditingController(),
        otp_2 = useTextEditingController(),
        otp_3 = useTextEditingController(),
        otp_4 = useTextEditingController(),
        otp_5 = useTextEditingController(),
        otp_6 = useTextEditingController();

    // countdown resent
    void startTimer() {
      const onsec = Duration(seconds: 1);
      timer.value = Timer.periodic(onsec, (timer) {
        if (start.value == 0) {
          timer.cancel();
          wait.value = false;
        } else {
          start.value--;
        }
      });
    }

    // get otp code
    Future<void> getOtpCode() async {
      await ref
          .read(otpVerificationControllerProvider.notifier)
          .getOtpCode(email: email);
    }

    // call once when build done
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getOtpCode();
        startTimer();
        wait.value = true;
      });

      return null;
    }, const []);

    // handle submit
    void submit() async {
      await ref.read(otpVerificationControllerProvider.notifier).verifyOtpCode(
            email: email,
            code: otp_1.text +
                otp_2.text +
                otp_3.text +
                otp_4.text +
                otp_5.text +
                otp_6.text,
            context: context,
            verifyType: verifyType,
          );
    }

    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        backgroundColor: AssetsConstants.whiteColor,
        appBar: const CustomeAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: AssetsConstants.defaultPadding,
              left: AssetsConstants.defaultPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.001),
                const LabelText(
                  content: 'Mã xác nhận OTP',
                  size: AssetsConstants.defaultFontSize - 5.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.02),
                LabelText(
                  maxLine: 2,
                  content:
                      'Hãy nhập mã gồm 6 số vừa được gửi đến email: $email',
                  size: AssetsConstants.defaultFontSize - 9.0,
                  fontWeight: FontWeight.w700,
                  color: AssetsConstants.subtitleColorM,
                ),
                SizedBox(height: size.height * 0.02),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OTPField(
                        size: size,
                        textController: otp_1,
                        isFirst: true,
                      ),
                      OTPField(
                        size: size,
                        textController: otp_2,
                      ),
                      OTPField(
                        size: size,
                        textController: otp_3,
                      ),
                      OTPField(
                        size: size,
                        textController: otp_4,
                      ),
                      OTPField(
                        size: size,
                        textController: otp_5,
                      ),
                      OTPField(
                        size: size,
                        textController: otp_6,
                        isFinal: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Bạn không nhận được mã?',
                        style: TextStyle(
                          fontSize: AssetsConstants.defaultFontSize - 9,
                          fontWeight: FontWeight.w500,
                          color: AssetsConstants.subtitleColorM,
                        ),
                      ),
                      TextSpan(
                        text: wait.value
                            ? ' Gửi lại (${start.value})'
                            : ' Gửi lại',
                        style: TextStyle(
                          fontSize: AssetsConstants.defaultFontSize - 9,
                          fontWeight: FontWeight.w700,
                          color: wait.value
                              ? AssetsConstants.subtitleColorM
                              : AssetsConstants.blackColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = wait.value
                              ? null
                              : () async {
                                  await getOtpCode();
                                  start.value = 10;
                                  startTimer();
                                  wait.value = true;
                                },
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
          child: ValueListenableBuilder6(
            first: otp_1,
            second: otp_2,
            third: otp_3,
            fourth: otp_4,
            fifth: otp_5,
            sixth: otp_6,
            builder: (_, a, b, c, d, e, f, __) => CustomButton(
              isActive: a.text.length +
                      b.text.length +
                      c.text.length +
                      d.text.length +
                      e.text.length +
                      f.text.length ==
                  6,
              content: 'Xác nhận',
              onCallback: submit,
            ),
          ),
        ),
      ),
    );
  }
}
