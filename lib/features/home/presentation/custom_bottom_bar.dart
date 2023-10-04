import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/constants/asset_constant.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.tabsRouter,
  });
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return CupertinoTabBar(
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      height: size.height * 0.06,
      backgroundColor: AssetsConstants.mainColor,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(
              top: AssetsConstants.defaultMargin - 6.0,
            ),
            width: size.width * 0.09,
            height: size.width * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AssetsConstants.defaultBorder,
              ),
              color: tabsRouter.activeIndex == 0
                  ? AssetsConstants.whiteColor
                  : AssetsConstants.mainColor,
            ),
            child: Icon(
              Icons.home,
              color: tabsRouter.activeIndex == 0
                  ? AssetsConstants.mainColor
                  : AssetsConstants.whiteColor,
              size: AssetsConstants.defaultFontSize - 6.0,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(
              top: AssetsConstants.defaultMargin - 6.0,
            ),
            width: size.width * 0.09,
            height: size.width * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AssetsConstants.defaultBorder,
              ),
              color: tabsRouter.activeIndex == 1
                  ? AssetsConstants.whiteColor
                  : AssetsConstants.mainColor,
            ),
            child: Icon(
              Icons.shopping_bag,
              color: tabsRouter.activeIndex == 1
                  ? AssetsConstants.mainColor
                  : AssetsConstants.whiteColor,
              size: AssetsConstants.defaultFontSize - 6.0,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(
              top: AssetsConstants.defaultMargin - 6.0,
            ),
            width: size.width * 0.09,
            height: size.width * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AssetsConstants.defaultBorder,
              ),
              color: tabsRouter.activeIndex == 2
                  ? AssetsConstants.whiteColor
                  : AssetsConstants.mainColor,
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.bowlFood,
                color: tabsRouter.activeIndex == 2
                    ? AssetsConstants.mainColor
                    : AssetsConstants.whiteColor,
                size: AssetsConstants.defaultFontSize - 6.0,
              ),
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(
              top: AssetsConstants.defaultMargin - 6.0,
            ),
            width: size.width * 0.09,
            height: size.width * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AssetsConstants.defaultBorder,
              ),
              color: tabsRouter.activeIndex == 3
                  ? AssetsConstants.whiteColor
                  : AssetsConstants.mainColor,
            ),
            child: Icon(
              Icons.account_box,
              color: tabsRouter.activeIndex == 3
                  ? AssetsConstants.mainColor
                  : AssetsConstants.whiteColor,
              size: AssetsConstants.defaultFontSize - 6.0,
            ),
          ),
        ),
      ],
    );
  }
}
