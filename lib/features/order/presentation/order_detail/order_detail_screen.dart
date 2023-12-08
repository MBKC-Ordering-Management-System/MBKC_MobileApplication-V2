import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/order_model.dart';
import 'modify_order_controller.dart';
import 'normal_row.dart';
import 'order_detail_controller.dart';
import 'product_row.dart';

final refreshOrderList = StateProvider.autoDispose<bool>(
  (ref) => true,
);

@RoutePage()
class OrderDetailScreen extends HookConsumerWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });
  final int orderId;

  Future<void> fetchData({
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<OrderModel?> order,
  }) async {
    final orderData = await ref
        .read(orderDetailControllerProvider.notifier)
        .getOrderDetail(context, orderId);

    order.value = orderData;
  }

  // change status
  void changeStatus({
    required OrderModel order,
    required BuildContext context,
    required WidgetRef ref,
    required VoidCallback onCallBack,
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
          .confirmOrder(order.id!, context);

      // context.router.pop(true);
      if (result) {
        onCallBack();
        ref
            .read(refreshOrderList.notifier)
            .update((state) => !ref.read(refreshOrderList));
      }
    }
  }

  // cancel order
  void cancelOrder({
    required OrderModel order,
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController controller,
    required VoidCallback onCallBack,
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
        title: 'Lý do hủy đơn hàng',
        controller: controller,
      );

      if (resultCancel != null && resultCancel) {
        final result =
            await ref.read(modifyOrderControllerProvider.notifier).cancelOrder(
                  id: order.id!,
                  context: context,
                  reason: controller.text.toString(),
                );
        // context.router.pop(true);

        if (result) {
          onCallBack();
          ref
              .read(refreshOrderList.notifier)
              .update((state) => !ref.read(refreshOrderList));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final order = useState<OrderModel?>(null);
    final confirmOrderState = ref.watch(modifyProfiver);
    final cancelReason = useTextEditingController();
    final getOrderDetail = ref.watch(orderDetailControllerProvider);

    // fetch data
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchData(ref: ref, context: context, order: order);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.data['screen'] == OrderDetailScreenRoute.name) {
          if (int.parse(message.data['orderid']) == orderId) {
            fetchData(ref: ref, context: context, order: order);
          }
        }
      });

      return;
    }, const []);

    return LoadingOverlay(
      isLoading: confirmOrderState,
      child: Scaffold(
        appBar: CustomAppBar(
          backButtonColor: AssetsConstants.whiteColor,
          title: 'Thông Tin Đơn Hàng',
          iconFirst: Icons.refresh_rounded,
          onCallBackFirst: () => fetchData(
            ref: ref,
            context: context,
            order: order,
          ),
        ),
        body: getOrderDetail.isLoading
            ? const HomeShimmer(amount: 4)
            : order.value == null
                ? const Align(
                    alignment: Alignment.topCenter,
                    child: EmptyBox(title: 'Sai thông tin'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalRow(
                          content: [
                            {
                              'Trạng thái hệ thống:': order.value!.systemStatus!
                            },
                            {
                              'Trạng thái đối tác:':
                                  order.value!.partnerOrderStatus!
                            },
                          ],
                        ),
                        NormalRow(
                          content: [
                            {'Mã hệ thống:': order.value!.id.toString()},
                            {
                              'Mã đối tác:':
                                  order.value!.orderPartnerId.toString()
                            },
                            {'Mã hiện thị:': order.value!.displayId.toString()},
                            {'Đối tác:': order.value!.partner!.name.toString()},
                          ],
                        ),
                        NormalRow(
                          content: [
                            {
                              'Họ tên người giao hàng:':
                                  order.value!.shipperName
                            },
                            {'Số điện thoại:': order.value!.shipperPhone},
                          ],
                        ),
                        NormalRow(
                          content: [
                            {'Họ tên khách hàng:': order.value!.customerName},
                            {'Số điện thoại:': order.value!.customerPhone},
                            {'Địa chỉ:': order.value!.address},
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: AssetsConstants.defaultPadding - 10.0,
                          ),
                          child: LabelText(
                            content: 'Chi tiết đơn hàng',
                            size: AssetsConstants.defaultFontSize - 13.0,
                            fontWeight: FontWeight.bold,
                            color: AssetsConstants.primaryDark,
                          ),
                        ),
                        ProductRow(orderDetails: order.value!.orderDetails!),
                        NormalRow(
                          content: [
                            {
                              'Dụng cụ ăn uống:':
                                  order.value!.cutlery == 1 ? 'Có' : 'Không'
                            },
                            {'Ghi chú:': order.value!.note},
                            if (order.value!.systemStatus!
                                    .toOrderSystemTypeEnum() ==
                                OrderSystemStatusType.cancelled)
                              {'Lí do hủy đơn:': order.value!.rejectedReason},
                          ],
                        ),
                        NormalRow(
                          content: [
                            {
                              'Phương thức thanh toán:': getTitlePaymentMethod(
                                  order.value!.paymentMethod!)
                            },
                            {
                              'Trạng thái thanh toán:':
                                  getStatusPaymentMethod(order.value!.isPaid!)
                            },
                          ],
                        ),
                        NormalRow(
                          content: [
                            {'Tạm tính:': order.value!.subTotalPrice},
                            {'Thuế:': order.value!.tax},
                            {
                              'Hoa hồng của đối tác:':
                                  order.value!.storePartnerCommission
                            },
                            {
                              'Thuế hoa hồng của đối tác:':
                                  order.value!.taxPartnerCommission
                            },
                            {
                              'Ưu đãi từ cửa hàng:':
                                  order.value!.totalStoreDiscount,
                            },
                            {
                              'Ưu đãi từ đối tác:': order.value!.promotionPrice,
                            },
                            {'Phí giao hàng:': order.value!.deliveryFee},
                            {'Tổng cộng:': order.value!.finalTotalPrice},
                            {'Tiền thu hộ:': order.value!.collectedPrice},
                          ],
                        ),
                        if (order.value!.shipperPayments != null &&
                            order.value!.shipperPayments!.isNotEmpty &&
                            order.value!.systemStatus!
                                    .toOrderSystemTypeEnum() ==
                                OrderSystemStatusType.completed)
                          NormalRow(
                            content: [
                              const {'Thanh toán của giao hàng': ''},
                              {
                                'Số tiền:':
                                    order.value!.shipperPayments!.last.amount
                              },
                              {
                                'Thời gian:': formatDateTime(order
                                    .value!.shipperPayments!.last.createDate!)
                              },
                              {
                                'Phương thức thanh toán:': order
                                            .value!
                                            .shipperPayments!
                                            .last
                                            .bankingAccount ==
                                        null
                                    ? 'Tiền mặt'
                                    : 'Chuyển khoản'
                              },
                              {'Thanh toán bởi:': order.value!.shipperName},
                              {
                                'Hình ảnh:':
                                    order.value!.orderHistories!.last.image
                              },
                            ],
                          ),
                        if (order.value!.shipperPayments != null &&
                            order.value!.shipperPayments!.isEmpty &&
                            order.value!.systemStatus!
                                    .toOrderSystemTypeEnum() ==
                                OrderSystemStatusType.completed)
                          NormalRow(
                            content: [
                              {
                                'Hình ảnh:':
                                    order.value!.orderHistories!.last.image
                              },
                            ],
                          ),
                      ],
                    ),
                  ),
        bottomNavigationBar: getOrderDetail.isLoading
            ? null
            : order.value == null
                ? null
                : (order.value!.partnerOrderStatus!.toOrderPartnerTypeEnum() ==
                            OrderPartnerStatusType.preparing ||
                        order.value!.partnerOrderStatus!
                                .toOrderPartnerTypeEnum() ==
                            OrderPartnerStatusType.upcoming)
                    ? Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AssetsConstants.borderColor,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: AssetsConstants.defaultPadding - 6.0,
                          horizontal: AssetsConstants.defaultPadding - 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: order.value!.partnerOrderStatus!
                                      .toOrderPartnerTypeEnum() ==
                                  OrderPartnerStatusType.preparing
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            if (order.value!.partnerOrderStatus!
                                    .toOrderPartnerTypeEnum() ==
                                OrderPartnerStatusType.preparing)
                              CustomButton(
                                isOutline: true,
                                width: size.width * 0.6,
                                height: size.height * 0.05,
                                content: 'Hoàn thành',
                                onCallback: () => changeStatus(
                                  order: order.value!,
                                  context: context,
                                  ref: ref,
                                  onCallBack: () async => await fetchData(
                                    ref: ref,
                                    context: context,
                                    order: order,
                                  ),
                                ),
                                isActive: (order.value!.partnerOrderStatus!
                                        .toOrderPartnerTypeEnum() ==
                                    OrderPartnerStatusType.preparing),
                                size: AssetsConstants.defaultFontSize - 10.0,
                                backgroundColor: AssetsConstants.whiteColor,
                                contentColor: AssetsConstants.mainColor,
                              ),
                            CustomButton(
                              isOutline: true,
                              width: order.value!.partnerOrderStatus!
                                          .toOrderPartnerTypeEnum() ==
                                      OrderPartnerStatusType.preparing
                                  ? size.width * 0.3
                                  : size.width * 0.9,
                              height: size.height * 0.05,
                              content: 'Hủy đơn',
                              onCallback: () => cancelOrder(
                                order: order.value!,
                                context: context,
                                ref: ref,
                                controller: cancelReason,
                                onCallBack: () async => await fetchData(
                                  ref: ref,
                                  context: context,
                                  order: order,
                                ),
                              ),
                              isActive: (order.value!.partnerOrderStatus!
                                          .toOrderPartnerTypeEnum() ==
                                      OrderPartnerStatusType.preparing ||
                                  order.value!.partnerOrderStatus!
                                          .toOrderPartnerTypeEnum() ==
                                      OrderPartnerStatusType.upcoming),
                              size: AssetsConstants.defaultFontSize - 10.0,
                              backgroundColor: AssetsConstants.whiteColor,
                              contentColor: AssetsConstants.warningColor,
                            ),
                          ],
                        ),
                      )
                    : null,
      ),
    );
  }
}
