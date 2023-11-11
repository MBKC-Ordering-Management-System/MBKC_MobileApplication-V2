import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../data/remote/money_exchange_source.dart';
import '../../data/repositories/money_exchange_repository.dart';
import '../models/money_exchange_model.dart';
import '../models/response/money_exchange_list_response.dart';
import '../../../../models/wallet_model.dart';

part 'money_exchange_repository.g.dart';

abstract class MoneyExchangeRepository {
  Future<MoneyExchangeListResponse> getMoneyExchanges({
    required String accessToken,
    required PagingModel request,
  });

  Future<WalletModel> getBalanceWallet({
    required String accessToken,
  });

  Future<MoneyExchangeModel> getDetailMoneyExchange({
    required String accessToken,
    required int moneyExchangeId,
  });
}

@Riverpod(keepAlive: true)
MoneyExchangeRepository moneyExchangeRepository(
  MoneyExchangeRepositoryRef ref,
) {
  final moneyExchangeSource = ref.read(moneyExchangeSourceProvider);
  return MoneyExchangeRepositoryImpl(moneyExchangeSource);
}
