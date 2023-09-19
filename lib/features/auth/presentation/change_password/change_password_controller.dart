import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/request/sign_in_request.dart';
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

    final request = SignInRequest(
      username: email,
      password: password,
    );

    state = await AsyncValue.guard(
      () => authRepository.changePassword(request: request),
    );

    if (state.hasError == false) {
      showSnackBar(
        context: context,
        content: 'Thay đổi mật khẩu thành công',
        icon: AssetsConstants.iconSuccess,
        backgroundColor: AssetsConstants.mainColor,
        textColor: AssetsConstants.whiteColor,
      );
      if (verifyType == VerificationOTPType.forgotpassword) {
        context.router.replaceAll([SignInScreenRoute()]);
      } else {}
    }
  }
}
