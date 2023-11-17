import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../configs/routes/app_router.dart';
import '../../../utils/commons/functions/functions_common_export.dart';
import '../../../utils/constants/api_constant.dart';
import '../../../utils/enums/enums_export.dart';
import '../../../utils/extensions/extensions_export.dart';
import '../../auth/domain/repositories/auth_repository.dart';
import '../domain/models/dashboard_model.dart';
import '../domain/repositories/dashboard_repository.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<DashBoardModel?> getStoreDashboard(
    BuildContext context,
  ) async {
    DashBoardModel? dashboard;
    state = const AsyncLoading();
    final dashboardRepository = ref.read(dashboardRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        dashboard = await dashboardRepository.getStoreDashboard(
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
        );
      },
    );

    if (state.hasError) {
      state = await AsyncValue.guard(
        () async {
          final statusCode = (state.error as DioException).onStatusDio();
          await handleAPIError(
            statusCode: statusCode,
            stateError: state.error!,
            context: context,
            onCallBackGenerateToken: reGenerateToken(authRepository, context),
          );

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }

          getStoreDashboard(context);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      }
    }

    return dashboard;
  }
}
