import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/models/category_model.dart';
import '../../domain/repositories/category_repository.dart';

part 'category_detail_controller.g.dart';

@riverpod
class CategoryDetailController extends _$CategoryDetailController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get category detail
  Future<CategoryModel?> getCategoryDetail(
    BuildContext context,
    int categoryId,
  ) async {
    CategoryModel? category;
    state = const AsyncLoading();
    final categoryRepository = ref.read(categoryRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        category = await categoryRepository.getCategoryDetail(
          categoryId: categoryId,
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

          getCategoryDetail(context, categoryId);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      }
    }

    return category;
  }
}
