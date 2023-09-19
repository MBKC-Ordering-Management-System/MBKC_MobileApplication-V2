import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/enums/enums_export.dart';
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
  Future<void> getOtpCode({required String email}) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(() => authRepository.getCode(email: email));
  }

  // verify code
  Future<void> verifyOtpCode({
    required String email,
    required String code,
    required BuildContext context,
    required VerificationOTPType verifyType,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    final request = OTPVerifyRequest(
      email: email,
      otpcode: code,
    );

    state = await AsyncValue.guard(
      () => authRepository.verifyCode(request: request),
    );

    if (state.hasError == false) {
      switch (verifyType) {
        case VerificationOTPType.forgotpassword:
          break;

        case VerificationOTPType.changepassword:
          break;

        default:
      }
    }
  }
}
