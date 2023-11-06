import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../models/response/money_exchange_list_response.dart';
import '../models/transaction_model.dart';

part 'wallet_repository.g.dart';

abstract class WalletRepository {
  Future<MoneyExchangeListResponse> getMoneyExchanges({
    required String accessToken,
    required PagingModel request,
  });

  Future<TransactionModel> getDetailMoneyExchange({
    required String accessToken,
    required int moneyExchangeId,
  });
}

@Riverpod(keepAlive: true)
WalletRepository walletRepository(WalletRepositoryRef ref) {
  return WalletRepositoryImpl();
}
