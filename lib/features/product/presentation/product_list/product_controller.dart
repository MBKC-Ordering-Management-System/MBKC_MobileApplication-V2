import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/models/product_model.dart';
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
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        final response = await productRepository.getProducts(
          request: request,
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
          storeId: user.id,
        );

        products = response.products;
      },
    );

    if (state.hasError) {
      state = await AsyncValue.guard(
        () async {
          final statusCode = (state.error as DioException).onStatusDio();
          await handleAPIError(
            statusCode: statusCode,
            stateError: state.error!,
            context: context,
            onCallBackGenerateToken: reGenerateToken(authRepository, context),
          );

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }

          products = await getProducts(request, context);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
      }
    }

    return products;
  }
}
