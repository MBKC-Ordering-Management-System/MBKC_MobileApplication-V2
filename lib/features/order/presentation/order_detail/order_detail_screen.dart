import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../models/order_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import 'normal_row.dart';
import 'product_row.dart';

@RoutePage()
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
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
                {'Mã:': order.orderid.toString()}
              ],
            ),
            ProductRow(orderDetails: order.orderDetails),
            NormalRow(
              content: [
                {'Phương thức thanh toán:': order.paymentMethod}
              ],
            ),
            NormalRow(
              content: [
                {'Họ tên khách hàng:': order.customerName},
                {'Số điện thoại:': order.customerPhone},
                {'Địa chỉ:': order.customerAddress},
              ],
            ),
            NormalRow(
              content: [
                {'Tạm tính:': order.subtotal},
                {'Giảm giá:': order.discount},
                {'Tổng cộng:': order.finalTotal},
              ],
            ),
            NormalRow(
              content: [
                {'Trạng thái:': order.status},
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: order.status == OrderStatusType.preparing
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
                onCallback: () {},
                isActive: order.status == OrderStatusType.preparing,
                size: AssetsConstants.defaultFontSize - 10.0,
              ),
            )
          : null,
    );
  }
}
