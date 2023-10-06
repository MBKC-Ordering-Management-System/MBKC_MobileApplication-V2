import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/product_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/repositories/product_repository.dart';

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get products
  Future<List<ProductModel>> getProducts(
    PagingModel request,
    BuildContext context,
  ) async {
    List<ProductModel> products = [];
    state = const AsyncLoading();
    final productRepository = ref.read(productRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        products = await productRepository.getProducts(request);
      },
    );

    if (state.hasError) {
      await handleAPIError(
        statusCode: StatusCodeType.badrequest.type,
        stateError: state.error!,
        context: context,
      );
    }

    return products;
  }
}
