import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';

class LinearHorizontal extends StatelessWidget {
  const LinearHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    // inti
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 1,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AssetsConstants.borderColor,
          ),
        ),
      ),
      padding:
          const EdgeInsets.only(bottom: AssetsConstants.defaultPadding - 10.0),
    );
  }
}
