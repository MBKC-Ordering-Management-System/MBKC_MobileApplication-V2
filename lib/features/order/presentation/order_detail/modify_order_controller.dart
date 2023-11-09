import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/repositories/order_repository.dart';

part 'modify_order_controller.g.dart';

@riverpod
class ModifyOrderController extends _$ModifyOrderController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // confirm orders
  Future<bool> confirmOrder(
    int id,
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    ref.read(modifyProfiver.notifier).update((state) => true);
    final orderRepository = ref.read(orderRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        await orderRepository.confirmOrder(
          orderId: id,
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
        );
        ref.read(modifyProfiver.notifier).update((state) => false);
        showSnackBar(
          context: context,
          content: 'Xác nhận thành công',
          icon: AssetsConstants.iconSuccess,
          backgroundColor: AssetsConstants.mainColor,
          textColor: AssetsConstants.whiteColor,
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

          confirmOrder(id, context);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      }
    }

    return true;
  }

  // cancel orders
  Future<bool> cancelOrder(
    int id,
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    ref.read(modifyProfiver.notifier).update((state) => true);
    final orderRepository = ref.read(orderRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        await orderRepository.cancelOrder(
          orderId: id,
          accessToken: APIConstants.prefixToken + user!.token.accessToken,
        );
        ref.read(modifyProfiver.notifier).update((state) => false);
        showSnackBar(
          context: context,
          content: 'Hủy đơn thành công',
          icon: AssetsConstants.iconSuccess,
          backgroundColor: AssetsConstants.mainColor,
          textColor: AssetsConstants.whiteColor,
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

          cancelOrder(id, context);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      }
    }

    return true;
  }
}
