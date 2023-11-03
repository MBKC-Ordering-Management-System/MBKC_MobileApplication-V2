import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/order_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import 'confirm_order_controller.dart';
import 'normal_row.dart';
import 'product_row.dart';

@RoutePage()
class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({
    super.key,
    required this.order,
  });
  final OrderModel order;

  // change status
  void changeStatus({
    required int id,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final result = await showAlertDialog(
      context: context,
      title: 'Xác nhận',
      content: 'Bạn muốn xác nhận đơn hàng đã hoàn thành ?',
      cancelActionText: 'Hủy',
    );
    if (result != null && result) {
      final result = await ref
          .read(confirmOrderControllerProvider.notifier)
          .confirmOrder(id, context);

      if (result) {
        context.router.pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final confirmOrderState = ref.watch(modifyProfiver);

    return LoadingOverlay(
      isLoading: confirmOrderState,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AssetsConstants.mainColor,
          centerTitle: true,
          title: const LabelText(
            content: 'Thông tin đơn hàng',
            size: AssetsConstants.defaultFontSize - 8.0,
            color: AssetsConstants.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NormalRow(
                content: [
                  {'Mã:': order.id.toString()}
                ],
              ),
              ProductRow(orderDetails: order.orderDetails!),
              NormalRow(
                content: [
                  {'Phương thức thanh toán:': order.paymentMethod}
                ],
              ),
              NormalRow(
                content: [
                  {'Họ tên khách hàng:': order.customerName},
                  {'Số điện thoại:': order.customerPhone},
                  {'Địa chỉ:': order.address},
                ],
              ),
              NormalRow(
                content: [
                  {'Tạm tính:': order.subTotalPrice},
                  {'Giảm giá:': order.totalDiscount},
                  {'Tổng cộng:': order.finalTotalPrice},
                ],
              ),
              NormalRow(
                content: [
                  {'Trạng thái:': order.systemStatus},
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: order.partnerOrderStatus!
                    .toOrderPartnerTypeEnum() ==
                OrderPartnerStatusType.preparing
            ? Container(
                margin: EdgeInsets.only(bottom: size.height * 0.04),
                padding: const EdgeInsets.only(
                  right: AssetsConstants.defaultPadding,
                  left: AssetsConstants.defaultPadding,
                ),
                child: CustomButton(
                  width: size.width * 1,
                  height: size.height * 0.05,
                  content: 'Hoàn thành',
                  onCallback: () =>
                      changeStatus(id: order.id!, context: context, ref: ref),
                  isActive: order.orderPartnerId!.toOrderPartnerTypeEnum() ==
                      OrderPartnerStatusType.preparing,
                  size: AssetsConstants.defaultFontSize - 10.0,
                ),
              )
            : null,
      ),
    );
  }
}
