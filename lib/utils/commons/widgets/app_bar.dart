import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import 'widgets_common_export.dart';

/// must implement [PreferredSizeWidget]
class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LabelText? title;
  final Color? backButtonColor;
  final Color? backgroundColor;
  final bool? centerTitle;

  const CustomeAppBar({
    super.key,
    this.title,
    this.backButtonColor = AssetsConstants.blackColor,
    this.centerTitle = true,
    this.backgroundColor = AssetsConstants.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: title,
      centerTitle: centerTitle,
      iconTheme: IconThemeData(
        color: backButtonColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
