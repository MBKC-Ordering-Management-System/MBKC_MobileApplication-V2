import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/api_utils.dart';
import '../../../../utils/commons/widgets/snack_bar.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/request/email_verify_request.dart';
import '../../domain/models/request/otp_verify_request.dart';
import '../../domain/repositories/auth_repository.dart';

part 'otp_verification_controller.g.dart';

@riverpod
class OtpVerificationController extends _$OtpVerificationController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get verify code
  Future<void> checkEmail({
    required String email,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    final request = EmailVerifyRequest(email: email);
    state = await AsyncValue.guard(
      () => authRepository.verifyEmail(request: request),
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
    }

    if (state.hasError == false) {
      showSnackBar(
        context: context,
        content: 'Mã OTP đã được gửi vào email của bạn',
        icon: AssetsConstants.iconSuccess,
        backgroundColor: AssetsConstants.mainColor,
        textColor: AssetsConstants.whiteColor,
      );
    }
  }

  // verify code
  Future<void> verifyOTPCode({
    required String email,
    required String code,
    required BuildContext context,
    required VerificationOTPType verifyType,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    final request = OTPVerifyRequest(
      email: email,
      otpCode: code,
    );

    state = await AsyncValue.guard(
      () => authRepository.verifyOTPCode(request: request),
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
    }

    if (state.hasError == false) {
      switch (verifyType) {
        case VerificationOTPType.forgotpassword:
          context.router.push(
            ChangePasswordScreenRoute(
              email: email,
              verifyType: verifyType,
            ),
          );
          break;

        case VerificationOTPType.changepassword:
          break;

        default:
          context.router.push(
            ChangePasswordScreenRoute(
              email: email,
              verifyType: verifyType,
            ),
          );
      }
    }
  }
}
