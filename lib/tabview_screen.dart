import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'configs/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/presentation/enter_email/enter_email_controller.dart';
import 'features/home/presentation/custom_bottom_bar.dart';
import 'utils/commons/widgets/widgets_common_export.dart';

@RoutePage()
class TabViewScreen extends ConsumerWidget {
  const TabViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final stateEnterEmail = ref.watch(enterEmailControllerProvider);

    return LoadingOverlay(
      isLoading: stateEnterEmail.isLoading,
      child: AutoTabsScaffold(
        routes: const [
          HomeScreenRoute(),
          OrderScreenRoute(),
          ProductScreenRoute(),
          ProfileScreenRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) =>
            CustomBottomBar(tabsRouter: tabsRouter),
      ),
    );
  }
}
