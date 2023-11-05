import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

part 'product_detail_controller.g.dart';

@riverpod
class ProductDetailController extends _$ProductDetailController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get product detail
  Future<ProductModel?> getProductDetail(
    BuildContext context,
    int productId,
  ) async {
    ProductModel? product;
    state = const AsyncLoading();
    final productRepository = ref.read(productRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        product = await productRepository.getProductDetail(
          productId: productId,
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
        );
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

          getProductDetail(context, productId);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
      }
    }

    return product;
  }
}
