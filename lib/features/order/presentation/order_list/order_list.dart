import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../models/order_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/order_status_type.dart';
import 'order_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    required this.orders,
    required this.orderType,
    required this.isLoading,
    required this.controller,
  });

  final List<OrderModel> orders;
  final OrderStatusType orderType;
  final bool isLoading;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return orders.isEmpty
        ? Container(
            width: size.width * 0.9,
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: AssetsConstants.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.boxArchive),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const LabelText(
                  content: 'Đơn hàng đang trống',
                  size: AssetsConstants.defaultFontSize,
                  color: AssetsConstants.whiteColor,
                ),
              ],
            ),
          )
        : Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller,
              padding: const EdgeInsets.symmetric(
                horizontal: AssetsConstants.defaultPadding - 10.0,
              ),
              itemCount: orders.length + 1,
              separatorBuilder: (_, __) => Divider(height: size.height * 0.015),
              itemBuilder: (_, index) {
                if (index == orders.length) {
                  return isLoading
                      ? Container(
                          padding: const EdgeInsets.only(
                            bottom: AssetsConstants.defaultPadding - 12.0,
                          ),
                          child: const Align(
                            child: CircularProgressIndicator(
                              color: AssetsConstants.mainColor,
                              backgroundColor:
                                  AssetsConstants.revenueBackground,
                            ),
                          ),
                        )
                      : Container();
                }
                return OrderItem(
                  order: orders[index],
                  orderType: orders[index].status,
                );
              },
            ),
          );
  }
}
