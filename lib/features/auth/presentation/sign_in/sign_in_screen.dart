import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../utils/commons/widgets/app_bar.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomeAppBar(),
      body: Center(
        child: LabelText(
          content: 'Login Screen',
          size: AssetsConstants.defaultFontSize + 5.0,
        ),
      ),
    );
  }
}
