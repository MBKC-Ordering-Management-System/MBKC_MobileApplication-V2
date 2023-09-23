import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/response/error_model.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/enums/enums_export.dart';
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
      },
    );

    if (state.hasError) {
      final errorModel = ErrorModel.fromMap(
        (state.error as DioException).response!.data as Map<String, dynamic>,
      );

      switch (errorModel.statusCode.toStatusCodeTypeEnum()) {
        case StatusCodeType.conflict:
        case StatusCodeType.notfound:
        case StatusCodeType.badrequest:
          showExceptionAlertDialog(
            context: context,
            title: errorModel.message.first.fieldNameError,
            exception: errorModel.message.first.descriptionError.first,
          );
          break;
        case StatusCodeType.exception:
          break;
        default:
          showExceptionAlertDialog(
            context: context,
            title: errorModel.message.first.fieldNameError,
            exception: errorModel.message.first.descriptionError.first,
          );
      }
    }

    if (state.hasError == false) {
      context.router.replaceAll([const HomeScreenRoute()]);
    }
  }
}
