import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/token_model.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../../profile/domain/repositories/profile_repository.dart';
import '../../domain/models/request/change_first_time_request.dart';
import '../../domain/models/request/change_password_request.dart';
import '../../domain/models/request/register_token_request.dart';
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
    TokenModel? token,
    UserModel? user,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    final profileRepository = ref.read(profileRepositoryProvider);

    final request = ChangePasswordRequest(
      email: email,
      newPassword: calculateMD5(password),
    );

    state = await AsyncValue.guard(
      () async {
        if (verifyType == VerificationOTPType.firsttimelog) {
          await authRepository.changeFirstTime(
            request: ChangeFirstTimeRequest(
              newPassword: calculateMD5(password),
            ),
            id: user!.accountId!,
            accessToken: APIConstants.prefixToken + token!.accessToken,
          );

          // register FCM token
          await authRepository.registerToken(
            request: RegisterTokenRequest(fcmToken: user.fcmToken!),
            accessToken: APIConstants.prefixToken + user.token.accessToken,
          );

          final profileWithUserDevice = await profileRepository.getProfile(
            APIConstants.prefixToken + user.token.accessToken,
          );

          final userModelWithUserDevice = user.copyWith(
            userTokens: profileWithUserDevice.userDevices,
          );

          ref.read(authProvider.notifier).update(
                (state) => userModelWithUserDevice,
              );
          await SharedPreferencesUtils.setInstance(
            userModelWithUserDevice,
            'user_token',
          );
          context.router.replaceAll([const HomeScreenRoute()]);
        } else {
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
