import '../../../../models/request/paging_model.dart';
import '../../../../models/response/success_model.dart';
import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/dummy_data/wallet_dummy_data.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/banking_account_model.dart';
import '../../domain/models/request/account_banking_request.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl extends RemoteBaseRepository
    implements WalletRepository {
  final bool addDelay;
  WalletRepositoryImpl({this.addDelay = true});

  @override
  Future<List<BankingAccountModel>> getBankingAccounts({
    required PagingModel request,
  }) async {
    await delay(addDelay);
    return WalletDummyData.bankingAccountsGenerate
        .skip((request.pageNumber - 1) * request.pageSize)
        .take(request.pageSize)
        .toList();
  }

  @override
  Future<List<TransactionModel>> getTransactions({
    required PagingModel request,
  }) async {
    await delay(addDelay);
    return WalletDummyData.transactionsGenerate
        .skip((request.pageNumber - 1) * request.pageSize)
        .take(request.pageSize)
        .toList();
  }

  @override
  Future<SuccessModel> createBankingAccount({
    required AccountBankingRequest request,
  }) async {
    await delay(addDelay);
    return SuccessModel(message: 'Create successfully.');
  }

  @override
  Future<SuccessModel> updateBankingAccount({
    required int id,
    required AccountBankingRequest request,
  }) async {
    await delay(addDelay);
    return SuccessModel(message: 'Update successfully.');
  }

  @override
  Future<SuccessModel> deleteBankingAccount({required int id}) async {
    await delay(addDelay);
    return SuccessModel(message: 'Delete successfully.');
  }
}
