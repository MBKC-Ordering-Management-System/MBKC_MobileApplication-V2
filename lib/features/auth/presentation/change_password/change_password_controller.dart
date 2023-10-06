import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../domain/models/request/change_password_request.dart';
import '../../domain/repositories/auth_repository.dart';

part 'change_password_controller.g.dart';

@riverpod
class ChangePasswordController extends _$ChangePasswordController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> changePassword({
    required String email,
    required String password,
    required BuildContext context,
    required VerificationOTPType verifyType,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    final request = ChangePasswordRequest(
      email: email,
      newPassword: calculateMD5(password),
    );

    state = await AsyncValue.guard(
      () async {
        await authRepository.changePassword(request: request);
        showSnackBar(
          context: context,
          content: 'Thay đổi mật khẩu thành công',
          icon: AssetsConstants.iconSuccess,
          backgroundColor: AssetsConstants.mainColor,
          textColor: AssetsConstants.whiteColor,
        );
        if (verifyType == VerificationOTPType.forgotpassword) {
          context.router.replaceAll([SignInScreenRoute()]);
        } else {
          context.router.pop();
        }
      },
    );

    if (state.hasError) {
      final statusCode = (state.error as DioException).onStatusDio();

      handleAPIError(
        statusCode: statusCode,
        stateError: state.error!,
        context: context,
      );
    }
  }
}
