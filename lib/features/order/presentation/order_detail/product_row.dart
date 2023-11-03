import 'package:flutter/material.dart';
import '../../domain/models/order_detail.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

class ProductRow extends StatelessWidget {
  const ProductRow({
    super.key,
    required this.orderDetails,
  });
  final List<OrderDetail> orderDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AssetsConstants.defaultPadding - 15.0,
        horizontal: AssetsConstants.defaultPadding - 10.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AssetsConstants.borderColor),
        ),
      ),
      child: Column(
        children: [
          ...orderDetails.map((e) => ProductDetail(orderDetail: e)),
        ],
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.orderDetail,
  });
  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AssetsConstants.defaultMargin - 8.0,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: LabelText(
                    content:
                        '${orderDetail.quantity}X  ${orderDetail.product!.name}',
                    size: AssetsConstants.defaultFontSize - 13.0,
                    fontWeight: FontWeight.w600,
                    color: AssetsConstants.mainColor,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: LabelText(
                      content:
                          getCustomContent({'Giá:': orderDetail.sellingPrice}),
                      size: AssetsConstants.defaultFontSize - 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AssetsConstants.defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...orderDetail.extraOrderDetails!.map((e) => LabelText(
                        content: e.toString(),
                        size: AssetsConstants.defaultFontSize - 14.0,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AssetsConstants.defaultPadding,
              ),
              child: LabelText(
                content: '> ${orderDetail.note}',
                size: AssetsConstants.defaultFontSize - 14.0,
                fontWeight: FontWeight.w600,
                color: AssetsConstants.skipText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
