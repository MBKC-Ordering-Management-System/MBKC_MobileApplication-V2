import '../../../../models/request/paging_model.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/response/category_list_response.dart';
import '../../domain/repositories/category_repository.dart';
import '../remote/category_source.dart';

class CategoryRepositoryImpl extends RemoteBaseRepository
    implements CategoryRepository {
  final bool addDelay;
  final CategorySource _categorySource;
  CategoryRepositoryImpl(this._categorySource, {this.addDelay = true});

  @override
  Future<CategoryListResponse> getCategories({
    required PagingModel request,
    required String accessToken,
  }) {
    return getDataOf(
      request: () => _categorySource.getCategories(
        APIConstants.contentType,
        accessToken,
        request.searchContent,
        request.filterContent,
        request.pageNumber,
        request.pageSize,
      ),
    );
  }

  @override
  Future<CategoryModel> getCategoryDetail({
    required int categoryId,
    required String accessToken,
  }) {
    return getDataOf(
      request: () => _categorySource.getCategoryDetail(
        APIConstants.contentType,
        accessToken,
        categoryId,
      ),
    );
  }
}
