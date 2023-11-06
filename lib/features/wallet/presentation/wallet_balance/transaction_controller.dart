import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/repositories/wallet_repository.dart';

part 'transaction_controller.g.dart';

@riverpod
class TransactionController extends _$TransactionController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get transactions
  Future<List<TransactionModel>> getMoneyExchanges(
    PagingModel request,
    BuildContext context,
  ) async {
    List<TransactionModel> transactions = [];
    state = const AsyncLoading();
    final walletRepository = ref.read(walletRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        final response = await walletRepository.getMoneyExchanges(
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
          request: request,
        );

        transactions = response.transactions;
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
        await authRepository.signOut();
      }
    }

    return transactions;
  }
}
