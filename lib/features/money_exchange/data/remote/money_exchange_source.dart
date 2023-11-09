import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/money_exchange_model.dart';
import '../../domain/models/response/money_exchange_list_response.dart';
import '../../domain/models/wallet_model.dart';

part 'money_exchange_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class MoneyExchangeSource {
  factory MoneyExchangeSource(Dio dio, {String baseUrl}) = _MoneyExchangeSource;

  @GET(APIConstants.moneyExchange)
  Future<HttpResponse<MoneyExchangeListResponse>> getMoneyExchanges(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Query('searchDateFrom') String? dateFrom,
    @Query('searchDateTo') String? dateTo,
    @Query('exchangeType') String? type,
    @Query('currentPage') int currentPage,
    @Query('itemsPerPage') int itemsPerPage,
  );

  @GET(APIConstants.wallet)
  Future<HttpResponse<WalletModel>> getBalanceWallet(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
  );

  @GET('${APIConstants.moneyExchange}/{id}')
  Future<HttpResponse<MoneyExchangeModel>> getMoneyExchangeDetail(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Path('id') int id,
  );
}

@riverpod
MoneyExchangeSource moneyExchangeSource(MoneyExchangeSourceRef ref) {
  final dio = ref.read(dioProvider);
  return MoneyExchangeSource(dio);
}
