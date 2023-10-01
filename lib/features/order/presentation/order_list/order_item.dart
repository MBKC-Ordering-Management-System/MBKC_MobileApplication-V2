import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../domain/models/order_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/order_status_type.dart';
import 'order_detail_item.dart';

class OrderItem extends ConsumerWidget {
  const OrderItem({
    super.key,
    required this.order,
    required this.orderType,
  });

  final OrderModel order;
  final OrderStatusType orderType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);

    // change status
    Future<void> changeStatus() async {
      final result = await showAlertDialog(
        context: context,
        title: 'Xác nhận',
        content: 'Bạn chắc chứ ?',
        cancelActionText: 'Hủy',
      );
      if (result != null && result) {
        showSnackBar(
          context: context,
          content: 'Hoàn thành',
          icon: AssetsConstants.iconSuccess,
          backgroundColor: AssetsConstants.mainColor,
          textColor: AssetsConstants.whiteColor,
        );
      }
      return;
    }

    return Container(
      padding: const EdgeInsets.all(AssetsConstants.defaultPadding - 15.0),
      margin: const EdgeInsets.only(bottom: AssetsConstants.defaultMargin),
      decoration: BoxDecoration(
        color: AssetsConstants.whiteColor,
        border: Border.all(color: AssetsConstants.subtitleColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.router.push(OrderDetailScreenRoute(order: order));
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
                            content: '#${order.orderid} • ${order.partner}',
                            size: AssetsConstants.defaultFontSize - 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                          LabelText(
                            content: '${order.totalItem} món',
                            size: AssetsConstants.defaultFontSize - 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                          if (order.note.isNotEmpty)
                            LabelText(
                              color: AssetsConstants.skipText,
                              content: '> ${order.note}',
                              size: AssetsConstants.defaultFontSize - 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      ),
                    ),
                    customButtonOrder(
                      width: size.width * 0.22,
                      height: size.height * 0.035,
                      content: order.status.type,
                      size: AssetsConstants.defaultFontSize - 18.0,
                      onCallBack: () {},
                      backgroundColor: getColorOrderStatus(orderType),
                      contentColor: AssetsConstants.whiteColor,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  width: size.width * 1,
                  height: 1,
                  color: AssetsConstants.subtitleColor,
                ),
                SizedBox(height: size.height * 0.005),
                ...order.orderDetails
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.only(
                          bottom: AssetsConstants.defaultMargin - 8.0,
                        ),
                        child: OrderDetailItem(orderDetail: e),
                      ),
                    )
                    .toList(),
                SizedBox(height: size.height * 0.01),
              ],
            ),
          ),
          if (orderType == OrderStatusType.preparing)
            CustomButton(
              size: AssetsConstants.defaultFontSize - 14.0,
              content: 'Hoàn thành'.toUpperCase(),
              onCallback: changeStatus,
              isActive: true,
              width: size.width * 0.90,
              height: size.height * 0.035,
            ),
          SizedBox(height: size.height * 0.005),
        ],
      ),
    );
  }
}

Widget customButtonOrder({
  required double width,
  required double height,
  required String content,
  required double size,
  required VoidCallback onCallBack,
  required Color backgroundColor,
  required Color contentColor,
}) {
  return InkWell(
    onTap: onCallBack,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        child: LabelText(
          content: content.toUpperCase(),
          size: size,
          color: contentColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
