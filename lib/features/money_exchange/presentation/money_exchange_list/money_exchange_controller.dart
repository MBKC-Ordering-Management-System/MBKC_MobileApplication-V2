import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/models/money_exchange_model.dart';
import '../../domain/repositories/money_exchange_repository.dart';

part 'money_exchange_controller.g.dart';

@riverpod
class MoneyExchangeController extends _$MoneyExchangeController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get money exchanges
  Future<List<MoneyExchangeModel>> getMoneyExchanges(
    PagingModel request,
    BuildContext context,
  ) async {
    List<MoneyExchangeModel> moneyExchanges = [];
    state = const AsyncLoading();
    final moneyExchangeRepository = ref.read(moneyExchangeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        final response = await moneyExchangeRepository.getMoneyExchanges(
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
          request: request,
        );

        moneyExchanges = response.moneyExchanges;
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

          getMoneyExchanges(request, context);
        },
      );
      // if refresh token expired
      if (state.hasError) {
        context.router.replaceAll([SignInScreenRoute()]);
        await authRepository.signOut();
      }
    }

    return moneyExchanges;
  }
}
