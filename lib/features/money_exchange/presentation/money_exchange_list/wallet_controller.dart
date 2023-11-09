import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/api_utils.dart';
import '../../../../utils/commons/functions/shared_preferences_utils.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/models/wallet_model.dart';
import '../../domain/repositories/money_exchange_repository.dart';

part 'wallet_controller.g.dart';

@riverpod
class WalletController extends _$WalletController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get product detail
  Future<WalletModel?> getBalance(
    BuildContext context,
  ) async {
    WalletModel? wallet;
    state = const AsyncLoading();
    final moneyExchangeRepository = ref.read(moneyExchangeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        wallet = await moneyExchangeRepository.getBalanceWallet(
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

          getBalance(context);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      }
    }

    return wallet;
  }
}
