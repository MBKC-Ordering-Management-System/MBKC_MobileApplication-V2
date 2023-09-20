import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'configs/routes/app_router.dart';
import 'features/home/presentation/custom_bottom_bar.dart';

@RoutePage()
class TabViewScreen extends StatelessWidget {
  const TabViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeScreenRoute(),
        OrderScreenRoute(),
        ProductScreenRoute(),
        ProfileScreenRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) =>
          CustomBottomBar(tabsRouter: tabsRouter),
    );
  }
}
