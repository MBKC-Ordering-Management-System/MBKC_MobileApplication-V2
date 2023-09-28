import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import 'widgets_common_export.dart';

/// must implement [PreferredSizeWidget]
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backButtonColor;
  final Color? backgroundColor;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    this.title,
    this.backButtonColor = AssetsConstants.blackColor,
    this.centerTitle = true,
    this.backgroundColor = AssetsConstants.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      iconTheme: IconThemeData(
        color: backButtonColor,
      ),
      title: LabelText(
        content: title ?? 'AppBar',
        size: AssetsConstants.defaultFontSize - 8.0,
        color: AssetsConstants.whiteColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
