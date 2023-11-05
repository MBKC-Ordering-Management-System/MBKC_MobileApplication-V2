import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/response/success_model.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/order_model.dart';
import '../../domain/models/response/order_list_response.dart';

part 'order_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class OrderSource {
  factory OrderSource(Dio dio, {String baseUrl}) = _OrderSource;

  @GET(APIConstants.order)
  Future<HttpResponse<OrderListResponse>> getOrders(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Query('systemStatus') String? orderSystemStatus,
    @Query('partnerOrderStatus') String? orderPartnerStatus,
    @Query('searchDateFrom') String? dateFrom,
    @Query('SearchDateTo') String? dateTo,
    @Query('currentPage') int currentPage,
    @Query('itemsPerPage') int itemsPerPage,
  );

  @GET('${APIConstants.order}/{id}')
  Future<HttpResponse<OrderModel>> getProductDetail(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Path('id') int id,
  );

  @PUT('${APIConstants.order}/{id}/change-order-to-ready')
  Future<HttpResponse<SuccessModel>> changeOrderToReady(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Path('id') int id,
  );

  @PUT('${APIConstants.order}/{id}/cancel-order')
  Future<HttpResponse<SuccessModel>> cancelOrder(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Path('id') int id,
  );
}

@riverpod
OrderSource orderSource(OrderSourceRef ref) {
  final dio = ref.read(dioProvider);
  return OrderSource(dio);
}
