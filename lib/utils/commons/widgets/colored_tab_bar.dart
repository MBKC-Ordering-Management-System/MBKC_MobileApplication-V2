import 'package:flutter/material.dart';

class ColoredTabBar extends Container implements PreferredSizeWidget {
  final Color backgroundColor;
  final TabBar tabBar;

  ColoredTabBar({
    super.key,
    required this.backgroundColor,
    required this.tabBar,
  });

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: backgroundColor,
        child: tabBar,
      );
}
