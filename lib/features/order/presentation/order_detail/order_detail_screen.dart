import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../models/order_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import 'normal_row.dart';

@RoutePage()
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
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
                {'Mã': order.orderid.toString()}
              ],
            ),
            NormalRow(
              content: [
                {'Phương thức thanh toán': order.paymentMethod}
              ],
            ),
            NormalRow(
              content: [
                {'Họ tên khách hàng': order.customerName},
                {'Số điện thoại': order.customerPhone},
                {'Địa chỉ': order.customerAddress},
              ],
            ),
            NormalRow(
              content: [
                {'Tạm tính': order.subtotal.toString()},
                {'Giảm giá': order.discount.toString()},
                {'Tổng cộng': order.finalTotal.toString()},
              ],
            ),
          ],
        ),
      ),
    );
  }
}
