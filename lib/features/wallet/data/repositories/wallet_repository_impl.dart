import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/response/money_exchange_list_response.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl extends RemoteBaseRepository
    implements WalletRepository {
  final bool addDelay;
  WalletRepositoryImpl({this.addDelay = true});

  @override
  Future<MoneyExchangeListResponse> getMoneyExchanges({
    required String accessToken,
    required PagingModel request,
  }) async {
    await delay(addDelay);
    return MoneyExchangeListResponse(
      totalPages: 1,
      numberItems: 2,
      transactions: [],
    );
  }

  @override
  Future<TransactionModel> getDetailMoneyExchange({
    required String accessToken,
    required int moneyExchangeId,
  }) async {
    await delay(addDelay);
    return TransactionModel(
      id: 1,
      amout: 10000,
      balance: 1000,
      from: 'from',
      to: 'to',
      date: 'date',
      type: MoneyExchangeType.receive,
      status: 'Active',
      content: 'HAHA',
    );
  }
}
