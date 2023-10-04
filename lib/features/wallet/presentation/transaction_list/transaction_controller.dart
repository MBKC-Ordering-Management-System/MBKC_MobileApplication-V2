import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/enums/enums_export.dart';
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
  Future<List<TransactionModel>> getTransactions(
      PagingModel paging, BuildContext context, TransactionType type) async {
    List<TransactionModel> transactions = [];

    state = const AsyncLoading();
    final walletRepository = ref.read(walletRepositoryProvider);
    state = await AsyncValue.guard(
      () async {
        transactions = await walletRepository.getTransactions(
          request: paging,
          type: type,
        );
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
      return [];
    }

    return transactions;
  }
}
