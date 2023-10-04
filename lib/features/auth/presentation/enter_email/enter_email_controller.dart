import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/request/email_verify_request.dart';
import '../../domain/repositories/auth_repository.dart';
part 'enter_email_controller.g.dart';

@riverpod
class EnterEmailController extends _$EnterEmailController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> checkEmail({
    required String email,
    required BuildContext context,
    required VerificationOTPType type,
  }) async {
    state = const AsyncLoading();
    ref.read(modifyProfiver.notifier).update((state) => true);
    final authRepository = ref.read(authRepositoryProvider);
    final request = EmailVerifyRequest(email: email);
    state = await AsyncValue.guard(
      () async {
        await authRepository.verifyEmail(request: request);
        ref.read(modifyProfiver.notifier).update((state) => false);
        context.router.push(
          OTPVerificationScreenRoute(
            email: email,
            verifyType: type,
          ),
        );
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
    }
  }
}
