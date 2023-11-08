import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/response/category_list_response.dart';

part 'category_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class CategorySource {
  factory CategorySource(Dio dio, {String baseUrl}) = _CategorySource;

  @GET(APIConstants.category)
  Future<HttpResponse<CategoryListResponse>> getCategories(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Query('searchValue') String? searchName,
    @Query('type') String? type,
    @Query('currentPage') int currentPage,
    @Query('itemsPerPage') int itemsPerPage,
  );

  @GET('${APIConstants.category}/{id}')
  Future<HttpResponse<CategoryModel>> getCategoryDetail(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Path('id') int id,
  );
}

@riverpod
CategorySource categorySource(CategorySourceRef ref) {
  final dio = ref.read(dioProvider);
  return CategorySource(dio);
}
