import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/remote/product_source.dart';
import '../../../../models/request/paging_model.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../models/product_model.dart';
import '../models/response/product_list_response.dart';

part 'product_repository.g.dart';

abstract class ProductRepository {
  Future<ProductListResponse> getProducts({
    required PagingModel request,
    required String accessToken,
  });

  Future<ProductModel> getProductDetail({
    required int productId,
    required String accessToken,
  });
}

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  final productSource = ref.read(productSourceProvider);
  return ProductRepositoryImpl(productSource);
}
