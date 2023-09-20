import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../utils/commons/widgets/app_bar.dart';
import '../../../utils/commons/widgets/label_text.dart';
import '../../../utils/constants/asset_constant.dart';

@RoutePage()
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomeAppBar(),
      body: Center(
        child: LabelText(
          content: 'Order Screen',
          size: AssetsConstants.defaultFontSize,
        ),
      ),
    );
  }
}
