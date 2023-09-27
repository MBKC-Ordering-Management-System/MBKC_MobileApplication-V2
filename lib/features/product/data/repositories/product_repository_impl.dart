import '../../../../models/product_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/functions/searching_utils.dart';
import '../../../../utils/dummy_data/product_dummy_data.dart';
import '../../../../utils/enums/searching_type_enum.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends RemoteBaseRepository
    implements ProductRepository {
  final bool addDelay;
  ProductRepositoryImpl({this.addDelay = true});
  @override
  Future<List<ProductModel>> getProducts(PagingModel request) async {
    await delay(addDelay);
    // search != null
    final typeSearch = getTypeSeaching(request);
    switch (typeSearch) {
      case SearchingType.search:
        return ProductDummyData.productsGenerate
            .where((item) => item.name.contains(request.searchContent!))
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList();
      case SearchingType.sortacs:
        return ProductDummyData.productsGenerate
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
      case SearchingType.sortdes:
        return ProductDummyData.productsGenerate
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
      case SearchingType.filter:
        return ProductDummyData.productsGenerate
            .where((item) => item.category == request.filterContent)
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList();
      case SearchingType.searchsortasc:
        return ProductDummyData.productsGenerate
            .where((item) => item.name.contains(request.searchContent!))
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
      case SearchingType.searchsortdesc:
        return ProductDummyData.productsGenerate
            .where((item) => item.name.contains(request.searchContent!))
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
      case SearchingType.searchfilter:
        return ProductDummyData.productsGenerate
            .where((item) =>
                item.name.contains(request.searchContent!) &&
                item.category == request.filterContent)
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList();
      case SearchingType.sortascfilter:
        return ProductDummyData.productsGenerate
            .where((item) => item.category == request.filterContent)
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));

      case SearchingType.sortdescfilter:
        return ProductDummyData.productsGenerate
            .where((item) => item.category == request.filterContent)
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));

      case SearchingType.searchsortascfilter:
        return ProductDummyData.productsGenerate
            .where((item) =>
                item.name.contains(request.searchContent!) &&
                item.category == request.filterContent)
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));

      case SearchingType.searchsortdescfilter:
        return ProductDummyData.productsGenerate
            .where((item) =>
                item.name.contains(request.searchContent!) &&
                item.category == request.filterContent)
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList()
          ..sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));

      case SearchingType.normal:
        return ProductDummyData.productsGenerate
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList();

      default:
        return ProductDummyData.productsGenerate
            .skip((request.pageNumber - 1) * request.pageSize)
            .take(request.pageSize)
            .toList();
    }
  }
}
