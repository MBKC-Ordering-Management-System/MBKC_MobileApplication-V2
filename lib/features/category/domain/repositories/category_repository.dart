import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../models/request/paging_model.dart';
import '../../data/remote/category_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../models/category_model.dart';
import '../models/response/category_list_response.dart';

part 'category_repository.g.dart';

abstract class CategoryRepository {
  Future<CategoryListResponse> getCategories({
    required PagingModel request,
    required String accessToken,
  });

  Future<CategoryModel> getCategoryDetail({
    required int categoryId,
    required String accessToken,
  });
}

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  final categorySource = ref.read(categorySourceProvider);
  return CategoryRepositoryImpl(categorySource);
}
