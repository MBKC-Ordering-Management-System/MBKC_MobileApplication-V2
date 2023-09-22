import 'package:flutter/material.dart';
import '../../../../models/order_detail_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

class OrderDetailItem extends StatelessWidget {
  const OrderDetailItem({
    super.key,
    required this.orderDetail,
  });
  final OrderDetailModel orderDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(
          content: '${orderDetail.quantity}X  ${orderDetail.productName}',
          size: AssetsConstants.defaultFontSize - 8.0,
          fontWeight: FontWeight.w600,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AssetsConstants.defaultPadding + 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...orderDetail.extra
                  .map((e) => LabelText(
                        content: e,
                        size: AssetsConstants.defaultFontSize - 10.0,
                        color: Colors.grey[700]!,
                        fontWeight: FontWeight.w600,
                      ))
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }
}
