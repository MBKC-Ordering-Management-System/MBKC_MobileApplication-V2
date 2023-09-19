import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'utils/commons/widgets/widgets_common_export.dart';
import 'utils/constants/asset_constant.dart';

@RoutePage()
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AssetsConstants.whiteColor,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.asset(
                  AssetsConstants.errorLogo,
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const LabelText(
                content: 'Ôi không! đã có lỗi xảy ra!',
                size: AssetsConstants.defaultFontSize,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: size.height * 0.02),
              const LabelText(
                content: 'Vui lòng nhấn quay lại.',
                size: AssetsConstants.defaultFontSize - 5.0,
                fontWeight: FontWeight.bold,
                color: AssetsConstants.subtitleColorM,
              ),
              SizedBox(height: size.height * 0.02),
              CustomOutlineButton(
                content: 'Quay lại'.toUpperCase(),
                onCallback: () {
                  context.router.removeLast();
                },
                outlineColor: AssetsConstants.mainColor,
                backgroundColor: AssetsConstants.whiteColor,
                textColor: AssetsConstants.mainColor,
                width: size.width * 0.5,
                height: size.height * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
