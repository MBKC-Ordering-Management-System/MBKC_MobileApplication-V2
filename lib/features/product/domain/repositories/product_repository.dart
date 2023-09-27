import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/product_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../data/repositories/product_repository_impl.dart';

part 'product_repository.g.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts(
    PagingModel request,
  );
}

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepositoryImpl();
}
