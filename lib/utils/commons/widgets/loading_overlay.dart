import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import '../../constants/asset_constant.dart';

class LoadingOverlay extends HookWidget {
  final Widget child;
  final bool isLoading;
  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(
              dismissible: false,
              color: AssetsConstants.blackColor,
            ),
          ),
        if (isLoading)
          Center(
            child: Lottie.asset(
              AssetsConstants.lottieLoading,
              width: size.width * 0.5,
              height: size.height * 0.5,
            ),
          ),
      ],
    );
  }
}
