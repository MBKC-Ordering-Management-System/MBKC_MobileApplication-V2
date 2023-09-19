import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';

class PaddingWidget extends StatelessWidget {
  const PaddingWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AssetsConstants.defaultPadding,
        left: AssetsConstants.defaultPadding,
      ),
      child: child,
    );
  }
}
