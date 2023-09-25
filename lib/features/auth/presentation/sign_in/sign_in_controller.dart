import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/token_model.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
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

        final userModel = UserModel(
          id: user.accountId,
          email: user.email,
          role: user.roleName,
        );
        ref.read(authProvider.notifier).update((state) => userModel);

        final token = TokenModel(
          accessToken: user.tokens.accessToken,
          refreshToken: user.tokens.refreshToken,
        );
        await SharedPreferencesUtils.setInstance(token, 'user_token');

        context.router.replaceAll([const HomeScreenRoute()]);
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
    }
  }
}
