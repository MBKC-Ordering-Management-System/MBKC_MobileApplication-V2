import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/presentation/sign_in/sign_in_controller.dart';
import '../../domain/models/category_model.dart';
import '../../domain/repositories/category_repository.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryController extends _$CategoryController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get categories
  Future<List<CategoryModel>> getCategories(
    PagingModel request,
    BuildContext context,
  ) async {
    List<CategoryModel> categories = [];
    state = const AsyncLoading();
    final categoryRepository = ref.read(categoryRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        final response = await categoryRepository.getCategories(
          request: request,
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
        );

        categories = response.categories;
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
            onCallBackGenerateToken: () async => await reGenerateToken(
              authRepository,
              context,
            ),
          );

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }

          getCategories(request, context);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await ref.read(signInControllerProvider.notifier).signOut(context);
      }
    }

    return categories;
  }
}
