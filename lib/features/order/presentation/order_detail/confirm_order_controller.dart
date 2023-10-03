import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../domain/repositories/order_repository.dart';

part 'confirm_order_controller.g.dart';

@riverpod
class ConfirmOrderController extends _$ConfirmOrderController {
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
    final orderRepository = ref.read(orderRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        await orderRepository.confirmOrder(id);
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
      handleAPIError(stateError: state.error!, context: context);
      return false;
    }

    return true;
  }
}
