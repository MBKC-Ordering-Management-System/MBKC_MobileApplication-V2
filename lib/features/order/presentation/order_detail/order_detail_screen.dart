import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../models/order_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';

@RoutePage()
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomeAppBar(),
      body: Center(
        child: LabelText(
          content: 'Orderdetail Screen',
          size: AssetsConstants.defaultFontSize,
        ),
      ),
    );
  }
}
