// ignore_for_file: unused_import
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../configs/routes/app_router.dart';
import '../../../utils/constants/asset_constant.dart';

class CustomBottomBar extends HookWidget {
  const CustomBottomBar({
    super.key,
    required this.tabsRouter,
  });
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // handle Terminated state
        RemoteMessage? initialMessage =
            await FirebaseMessaging.instance.getInitialMessage();
        if (initialMessage?.data['screen'] == OrderDetailScreenRoute.name) {
          tabsRouter.setActiveIndex(1);
          context.router.push(OrderDetailScreenRoute(
            orderId: int.parse(initialMessage?.data['orderid']),
          ));
        }
      });

      // handle Background state
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (message.data['screen'] == OrderDetailScreenRoute.name) {
          tabsRouter.setActiveIndex(1);
          context.router.push(OrderDetailScreenRoute(
            orderId: int.parse(message.data['orderid']),
          ));
        }
      });

      return null;
    }, const []);

    return CupertinoTabBar(
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      height: size.height * 0.06,
      backgroundColor: AssetsConstants.whiteColor,
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
                  ? AssetsConstants.primaryLight
                  : AssetsConstants.whiteColor,
            ),
            child: const Icon(
              Icons.home,
              color: AssetsConstants.primaryDark,
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
                  ? AssetsConstants.primaryLight
                  : AssetsConstants.whiteColor,
            ),
            child: const Icon(
              Icons.shopping_bag,
              color: AssetsConstants.primaryDark,
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
                  ? AssetsConstants.primaryLight
                  : AssetsConstants.whiteColor,
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.bowlFood,
                color: AssetsConstants.primaryDark,
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
                  ? AssetsConstants.primaryLight
                  : AssetsConstants.whiteColor,
            ),
            child: const Icon(
              Icons.account_box,
              color: AssetsConstants.primaryDark,
              size: AssetsConstants.defaultFontSize - 6.0,
            ),
          ),
        ),
      ],
    );
  }
}
