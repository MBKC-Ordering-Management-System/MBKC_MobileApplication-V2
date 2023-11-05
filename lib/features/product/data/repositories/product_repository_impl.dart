import '../../../../utils/constants/api_constant.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/product_model.dart';
import '../../domain/models/response/product_list_response.dart';
import '../../domain/repositories/product_repository.dart';
import '../remote/product_source.dart';

class ProductRepositoryImpl extends RemoteBaseRepository
    implements ProductRepository {
  final bool addDelay;
  final ProductSource _productSource;
  ProductRepositoryImpl(this._productSource, {this.addDelay = true});

  @override
  Future<ProductListResponse> getProducts({
    required PagingModel request,
    required String accessToken,
    required int storeId,
  }) async {
    return getDataOf(
      request: () => _productSource.getProducts(
        APIConstants.contentType,
        accessToken,
        request.searchContent,
        request.sortContent,
        request.filterContent,
        request.pageNumber,
        request.pageSize,
        storeId,
      ),
    );
  }

  @override
  Future<ProductModel> getProductDetail({
    required int productId,
    required String accessToken,
  }) {
    return getDataOf(
      request: () => _productSource.getProductDetail(
        APIConstants.contentType,
        accessToken,
        productId,
      ),
    );
  }
}
