import '../../../../models/request/paging_model.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/money_exchange_model.dart';
import '../../domain/models/response/money_exchange_list_response.dart';
import '../../domain/models/wallet_model.dart';
import '../../domain/repositories/money_exchange_repository.dart';
import '../remote/money_exchange_source.dart';

class MoneyExchangeRepositoryImpl extends RemoteBaseRepository
    implements MoneyExchangeRepository {
  final bool addDelay;
  final MoneyExchangeSource _moneyExchangeSource;
  MoneyExchangeRepositoryImpl(this._moneyExchangeSource,
      {this.addDelay = true});

  @override
  Future<MoneyExchangeListResponse> getMoneyExchanges({
    required String accessToken,
    required PagingModel request,
  }) async {
    return getDataOf(
      request: () => _moneyExchangeSource.getMoneyExchanges(
        APIConstants.contentType,
        accessToken,
        request.searchDateFrom,
        request.searchDateTo,
        request.filterContent,
        request.pageNumber,
        request.pageSize,
      ),
    );
  }

  @override
  Future<MoneyExchangeModel> getDetailMoneyExchange({
    required String accessToken,
    required int moneyExchangeId,
  }) async {
    return getDataOf(
      request: () => _moneyExchangeSource.getMoneyExchangeDetail(
        APIConstants.contentType,
        accessToken,
        moneyExchangeId,
      ),
    );
  }

  @override
  Future<WalletModel> getBalanceWallet({required String accessToken}) {
    return getDataOf(
      request: () => _moneyExchangeSource.getBalanceWallet(
        APIConstants.contentType,
        accessToken,
      ),
    );
  }
}
