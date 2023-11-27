// ignore_for_file: unused_local_variable
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/order_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/order_partner_status_type.dart';
import '../order_detail/modify_order_controller.dart';
import 'order_detail_item.dart';

class OrderItem extends HookConsumerWidget {
  const OrderItem({
    super.key,
    required this.order,
    required this.onCallback,
  });

  final OrderModel order;
  final VoidCallback onCallback;

  // change status
  void changeStatus({
    required int id,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final result = await showAlertDialog(
      context: context,
      title: 'Xác nhận',
      content:
          'Bạn muốn xác nhận đơn hàng #${order.id} từ đối tác ${order.partner!.name} đã hoàn thành ?',
      cancelActionText: 'Hủy',
    );
    if (result != null && result) {
      final result = await ref
          .read(modifyOrderControllerProvider.notifier)
          .confirmOrder(id, context);

      if (result) {
        onCallback();
      }
    }
  }

  // change status
  void cancelOrder({
    required int id,
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController controller,
    required AsyncValue<void> isLoading,
  }) async {
    final resultConfirm = await showAlertDialog(
      context: context,
      title: 'Xác nhận',
      content:
          'Bạn muốn hủy đơn #${order.id} từ đối tác ${order.partner!.name} không?',
      cancelActionText: 'Hủy',
    );

    if (resultConfirm != null && resultConfirm) {
      controller.clear();
      final resultCancel = await showAlertDialogCancelReason(
        context: context,
        title: 'Hủy đơn hàng',
        controller: controller,
      );

      if (resultCancel != null && resultCancel) {
        final result =
            await ref.read(modifyOrderControllerProvider.notifier).cancelOrder(
                  id: id,
                  context: context,
                  reason: controller.text.toString(),
                );

        if (result) {
          onCallback();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final cancelReason = useTextEditingController();
    final state = ref.watch(modifyProfiver);
    final stateModify = ref.watch(modifyOrderControllerProvider);

    return Container(
      padding: const EdgeInsets.all(AssetsConstants.defaultPadding - 12.0),
      margin: const EdgeInsets.only(bottom: AssetsConstants.defaultMargin),
      decoration: BoxDecoration(
        color: AssetsConstants.whiteColor,
        border: Border.all(color: AssetsConstants.subtitleColor),
        borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.router.push(OrderDetailScreenRoute(orderId: order.id!));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelText(
                            content: '#${order.id} • ${order.partner!.name}',
                            size: AssetsConstants.defaultFontSize - 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                          LabelText(
                            content: '${order.totalQuantity} món',
                            size: AssetsConstants.defaultFontSize - 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                          if (order.note!.isNotEmpty)
                            LabelText(
                              color: AssetsConstants.skipText,
                              content: '> ${order.note}',
                              size: AssetsConstants.defaultFontSize - 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      ),
                    ),
                    CustomLabelStatus(
                      width: size.width * 0.22,
                      height: size.height * 0.035,
                      content: getTitlePartnerStatus(
                          order.partnerOrderStatus!.toOrderPartnerTypeEnum()),
                      size: AssetsConstants.defaultFontSize - 18.0,
                      backgroundColor: getBackgroundColorPartnerStatus(
                          order.partnerOrderStatus!.toOrderPartnerTypeEnum()),
                      contentColor: getContentColorPartnerStatus(
                          order.partnerOrderStatus!.toOrderPartnerTypeEnum()),
                    ),
                    SizedBox(width: size.width * 0.01),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  width: size.width * 1,
                  height: 1,
                  color: AssetsConstants.subtitleColor,
                ),
                SizedBox(height: size.height * 0.005),
                ...order.orderDetails!.map((e) => Container(
                      margin: const EdgeInsets.only(
                        bottom: AssetsConstants.defaultMargin - 8.0,
                      ),
                      child: OrderDetailItem(orderDetail: e),
                    )),
                SizedBox(height: size.height * 0.01),
              ],
            ),
          ),
          if (order.partnerOrderStatus!.toOrderPartnerTypeEnum() ==
              OrderPartnerStatusType.preparing) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  isOutline: true,
                  size: AssetsConstants.defaultFontSize - 14.0,
                  content: 'Hoàn thành'.toUpperCase(),
                  onCallback: () => changeStatus(
                    id: order.id!,
                    context: context,
                    ref: ref,
                  ),
                  isActive: true,
                  width: size.width * 0.55,
                  height: size.height * 0.04,
                  backgroundColor: AssetsConstants.whiteColor,
                  contentColor: AssetsConstants.mainColor,
                ),
                CustomButton(
                  isOutline: true,
                  size: AssetsConstants.defaultFontSize - 14.0,
                  content: 'Hủy đơn'.toUpperCase(),
                  onCallback: () => cancelOrder(
                    isLoading: stateModify,
                    id: order.id!,
                    context: context,
                    ref: ref,
                    controller: cancelReason,
                  ),
                  isActive: true,
                  width: size.width * 0.3,
                  height: size.height * 0.04,
                  backgroundColor: AssetsConstants.whiteColor,
                  contentColor: AssetsConstants.warningColor,
                ),
              ],
            ),
          ],
          if (order.partnerOrderStatus!.toOrderPartnerTypeEnum() ==
              OrderPartnerStatusType.upcoming)
            CustomButton(
              isOutline: true,
              size: AssetsConstants.defaultFontSize - 14.0,
              content: 'Hủy đơn'.toUpperCase(),
              onCallback: () => cancelOrder(
                isLoading: stateModify,
                id: order.id!,
                context: context,
                ref: ref,
                controller: cancelReason,
              ),
              isActive: true,
              width: size.width * 1,
              height: size.height * 0.04,
              backgroundColor: AssetsConstants.whiteColor,
              contentColor: AssetsConstants.warningColor,
            ),
          SizedBox(height: size.height * 0.005),
        ],
      ),
    );
  }
}
