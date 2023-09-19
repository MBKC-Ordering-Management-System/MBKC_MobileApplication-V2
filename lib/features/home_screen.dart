import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../utils/commons/widgets/widgets_common_export.dart';
import '../utils/constants/asset_constant.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomeAppBar(),
      body: Center(
        child: LabelText(
          content: 'Home Screen',
          size: AssetsConstants.defaultFontSize + 5.0,
        ),
      ),
    );
  }
}
