import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'configs/routes/app_router.dart';
import 'utils/commons/widgets/widgets_common_export.dart';
import 'utils/constants/asset_constant.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateTo();
  }

  _navigateTo() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    context.router.replaceAll([const SignInScreenRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AssetsConstants.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AssetsConstants.appLogo,
                width: 180,
                height: 180,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const LabelText(
              content: AssetsConstants.appTitle,
              size: AssetsConstants.defaultFontSize + 5.0,
              fontWeight: FontWeight.bold,
              color: AssetsConstants.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
