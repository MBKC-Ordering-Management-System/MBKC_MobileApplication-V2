import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/response/product_list_response.dart';

part 'product_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class ProductSource {
  factory ProductSource(Dio dio, {String baseUrl}) = _ProductSource;

  @GET(APIConstants.getproducts)
  Future<HttpResponse<ProductListResponse>> getProducts(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Query('searchName') String? searchName,
    @Query('productType') String? productType,
    @Query('currentPage') int currentPage,
    @Query('itemsPerPage') int itemsPerPage,
  );
}

@riverpod
ProductSource productSource(ProductSourceRef ref) {
  final dio = ref.read(dioProvider);
  return ProductSource(dio);
}
