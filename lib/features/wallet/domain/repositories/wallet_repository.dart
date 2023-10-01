import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../models/response/success_model.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../models/banking_account_model.dart';
import '../models/request/account_banking_request.dart';
import '../models/transaction_model.dart';

part 'wallet_repository.g.dart';

abstract class WalletRepository {
  Future<List<BankingAccountModel>> getBankingAccounts({
    required PagingModel request,
  });

  Future<List<TransactionModel>> getTransactions({
    required PagingModel request,
  });

  Future<SuccessModel> createBankingAccount({
    required AccountBankingRequest request,
  });

  Future<SuccessModel> updateBankingAccount({
    required int id,
    required AccountBankingRequest request,
  });

  Future<SuccessModel> deleteBankingAccount({required int id});
}

@Riverpod(keepAlive: true)
WalletRepository walletRepository(WalletRepositoryRef ref) {
  return WalletRepositoryImpl();
}
