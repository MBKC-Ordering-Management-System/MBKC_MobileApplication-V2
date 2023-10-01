import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../domain/models/banking_account_model.dart';
import '../../domain/repositories/wallet_repository.dart';

part 'banking_account_controller.g.dart';

@riverpod
class BankingAccountController extends _$BankingAccountController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get banking accounts
  Future<List<BankingAccountModel>> getBankingAccounts(
    PagingModel request,
    BuildContext context,
  ) async {
    List<BankingAccountModel> accounts = [];
    state = const AsyncLoading();
    final walletRepository = ref.read(walletRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        accounts = await walletRepository.getBankingAccounts(request: request);
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
    }

    return accounts;
  }

  // delete banking account
  Future<bool> deleteBankingAccount(
    int id,
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    final walletRepository = ref.read(walletRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        await walletRepository.deleteBankingAccount(id: id);
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
      return false;
    }

    showSnackBar(
      context: context,
      content: 'Xóa thành công',
      icon: AssetsConstants.iconSuccess,
      backgroundColor: AssetsConstants.mainColor,
      textColor: AssetsConstants.whiteColor,
    );

    return true;
  }
}
