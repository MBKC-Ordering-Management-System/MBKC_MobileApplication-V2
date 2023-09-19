import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      height: size.height * 0.06,
      decoration: const BoxDecoration(
        color: AssetsConstants.mainColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_box),
          ),
        ],
      ),
    );
  }
}
