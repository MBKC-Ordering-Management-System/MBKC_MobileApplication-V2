import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/user_model.dart';
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

  Future<void> login(
    String username,
    String password,
    BuildContext context,
  ) async {
    UserModel user;

    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    final request = SignInRequest(
      username: username,
      password: password,
    );

    state = await AsyncValue.guard(
      () async {
        user = await authRepository.signIn(request: request);
        ref.read(authProvider.notifier).update((state) => user);
      },
    );

    if (state.hasError == false) {
      context.router.replaceAll([const HomeScreenRoute()]);
    }
  }
}
