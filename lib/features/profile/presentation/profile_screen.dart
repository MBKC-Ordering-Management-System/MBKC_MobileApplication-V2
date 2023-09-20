import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../utils/commons/widgets/app_bar.dart';
import '../../../utils/commons/widgets/label_text.dart';
import '../../../utils/constants/asset_constant.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomeAppBar(),
      body: Center(
        child: LabelText(
          content: 'Profile Screen',
          size: AssetsConstants.defaultFontSize,
        ),
      ),
    );
  }
}
