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
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../../utils/providers/common_provider.dart';
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

        final userModel = UserModel(
          id: user.accountId,
          email: user.email,
          role: user.roleName,
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

        ref.read(authProvider.notifier).update((state) => userModel);
        await SharedPreferencesUtils.setInstance(user.tokens, 'user_token');
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

  void signOut(
    BuildContext context,
  ) async {
    final authRepository = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        ref.read(authProvider.notifier).update((state) => null);
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      },
    );
  }
}
