import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/response/error_detail_model.dart';
import '../../../../models/response/error_model.dart';
import '../../../../models/token_model.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../../profile/domain/repositories/profile_repository.dart';
import '../../domain/models/request/register_token_request.dart';
import '../../domain/models/request/sign_in_request.dart';
import '../../domain/repositories/auth_repository.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> signIn(
    String username,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    final profileRepository = ref.read(profileRepositoryProvider);
    final request = SignInRequest(
      email: username,
      password: calculateMD5(password),
    );

    state = await AsyncValue.guard(
      () async {
        final user = await authRepository.signIn(request: request);

        // check role user
        if (user.roleName != 'Store Manager') {
          final error = ErrorModel(
            statusCode: StatusCodeType.forbidden.type,
            message: [
              ErrorDetailModel(
                fieldNameError: 'account',
                descriptionError: [
                  'You are not allowed to access this function!'
                ],
              ),
            ],
          );

          throw DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: StatusCodeType.forbidden.type,
              data: error.toMap(),
            ),
          );
        }

        final profile = await profileRepository.getProfile(
          APIConstants.prefixToken + user.tokens.accessToken,
        );

        // get FCM token
        final deviceToken = await getDeviceToken();
        final userModel = UserModel(
          accountId: user.accountId,
          storeId: profile.storeId,
          email: user.email,
          token: user.tokens,
          fcmToken: deviceToken,
        );

        // check first time log
        if (user.isConfirmed == false) {
          context.router.push(
            ChangePasswordScreenRoute(
              email: user.email,
              verifyType: VerificationOTPType.firsttimelog,
              token: TokenModel(
                accessToken: user.tokens.accessToken,
                refreshToken: user.tokens.refreshToken,
              ),
              user: userModel,
            ),
          );
          return;
        }

        // register FCM token
        await authRepository.registerToken(
          request: RegisterTokenRequest(fcmToken: deviceToken),
          accessToken: APIConstants.prefixToken + userModel.token.accessToken,
        );

        final profileWithUserDevice = await profileRepository.getProfile(
          APIConstants.prefixToken + user.tokens.accessToken,
        );

        final userModelWithUserDevice = userModel.copyWith(
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
      },
    );

    if (state.hasError) {
      if (kDebugMode) {
        print(state.error);
      }
      final statusCode = (state.error as DioException).onStatusDio();
      handleAPIError(
        statusCode: statusCode,
        stateError: state.error!,
        context: context,
      );
    }
  }

  Future<void> signOut(
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    ref.read(modifyProfiver.notifier).update((state) => true);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        final userDevice = user!.userTokens!.firstWhere(
          (element) => element.fcmToken == user.fcmToken,
        );

        ref.read(authProvider.notifier).update((state) => null);
        await authRepository.signOut();
        await authRepository.deleteToken(
          id: userDevice.userDeviceId!,
        );

        ref.read(modifyProfiver.notifier).update((state) => false);
        context.router.replaceAll([SignInScreenRoute()]);
      },
    );

    // access expired || other error
    if (state.hasError) {
      state = await AsyncValue.guard(
        () async {
          final statusCode = (state.error as DioException).onStatusDio();
          await handleAPIError(
            statusCode: statusCode,
            stateError: state.error!,
            context: context,
            onCallBackGenerateToken: () => reGenerateToken(
              authRepository,
              context,
            ),
          );

          // if refresh token expired
          if (state.hasError) {
            ref.read(modifyProfiver.notifier).update((state) => false);
            showExceptionAlertDialog(
              context: context,
              title: 'Thông báo',
              exception: 'Có lỗi rồi không thể đăng xuất.',
            );
            return;
          }

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }

          await signOut(context);
        },
      );
    }
  }
}
