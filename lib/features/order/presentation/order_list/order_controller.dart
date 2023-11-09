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
import '../../domain/models/order_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../domain/repositories/order_repository.dart';

part 'order_controller.g.dart';

@riverpod
class OrderController extends _$OrderController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get orders
  Future<List<OrderModel>> getOrders(
    PagingModel request,
    BuildContext context,
  ) async {
    List<OrderModel> orders = [];
    state = const AsyncLoading();
    final orderRepository = ref.read(orderRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        final response = await orderRepository.getOrders(
          request: request,
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
        );

        orders = response.orders;
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

          getOrders(request, context);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      }
    }

    return orders;
  }
}
