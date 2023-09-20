import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';

@RoutePage()
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomeAppBar(),
      body: Center(
        child: LabelText(
          content: 'Product Screen',
          size: AssetsConstants.defaultFontSize,
        ),
      ),
    );
  }
}
