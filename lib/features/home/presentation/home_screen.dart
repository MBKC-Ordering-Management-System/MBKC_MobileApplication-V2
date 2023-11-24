import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../utils/commons/functions/functions_common_export.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';
import '../domain/models/dashboard_model.dart';
import 'dashboard_controller.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  // fetch data
  Future<void> fetchData({
    required ValueNotifier<DashBoardModel?> dashboard,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await ref
        .read(dashboardControllerProvider.notifier)
        .getStoreDashboard(context: context, dashboard: dashboard);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final dashboard = useState<DashBoardModel?>(null);
    final state = ref.watch(dashboardControllerProvider);

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchData(dashboard: dashboard, ref: ref, context: context);
      });

      () async {
        await delay(true);
      };

      FlutterNativeSplash.remove();
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: CustomAppBar(
        title: 'Trang Chủ',
        iconFirst: Icons.refresh_rounded,
        onCallBackFirst: () async =>
            await fetchData(dashboard: dashboard, ref: ref, context: context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AssetsConstants.defaultPadding - 6.0,
        ),
        child: dashboard.value == null && state.isLoading == false
            ? const HomeShimmer(amount: 2)
            : Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  StatisticalCard(
                    loadingColor: AssetsConstants.secondaryDark,
                    state: state,
                    backgroundColor: AssetsConstants.secondaryLighter,
                    contentColor: AssetsConstants.secondaryDark,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: AssetsConstants.secondaryDark,
                      size: AssetsConstants.defaultFontSize - 6.0,
                    ),
                    title: dashboard.value == null
                        ? ''
                        : dashboard.value!.totalUpcomingOrders.toString(),
                    subtitle: 'Tổng số đơn hàng sắp tới',
                  ),
                  SizedBox(height: size.height * 0.02),
                  StatisticalCard(
                    loadingColor: AssetsConstants.secondaryDark,
                    state: state,
                    backgroundColor: AssetsConstants.secondaryLighter,
                    contentColor: AssetsConstants.secondaryDark,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: AssetsConstants.secondaryDark,
                      size: AssetsConstants.defaultFontSize - 6.0,
                    ),
                    title: dashboard.value == null
                        ? ''
                        : dashboard.value!.totalPreparingOrders.toString(),
                    subtitle: 'Tổng số đơn hàng đang chuẩn bị',
                  ),
                  SizedBox(height: size.height * 0.02),
                  StatisticalCard(
                    loadingColor: AssetsConstants.warningDarker,
                    state: state,
                    backgroundColor: AssetsConstants.warningLighter,
                    contentColor: AssetsConstants.warningDarker,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: AssetsConstants.warningDarker,
                      size: AssetsConstants.defaultFontSize - 6.0,
                    ),
                    title: dashboard.value == null
                        ? ''
                        : dashboard.value!.totalReadyOrders.toString(),
                    subtitle: 'Tổng số đơn hàng sẵn sàng',
                  ),
                  SizedBox(height: size.height * 0.02),
                  StatisticalCard(
                    loadingColor: AssetsConstants.successDarker,
                    state: state,
                    backgroundColor: AssetsConstants.successLighter,
                    contentColor: AssetsConstants.successDarker,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: AssetsConstants.successDarker,
                      size: AssetsConstants.defaultFontSize - 6.0,
                    ),
                    title: dashboard.value == null
                        ? ''
                        : dashboard.value!.totalCompletedOrders.toString(),
                    subtitle: 'Tổng số đơn hàng hoàn thành',
                  ),
                  SizedBox(height: size.height * 0.02),
                  StatisticalCard(
                    loadingColor: AssetsConstants.mainColor,
                    state: state,
                    backgroundColor: AssetsConstants.revenueBackground,
                    contentColor: AssetsConstants.mainColor,
                    icon: const Icon(
                      Icons.wallet_rounded,
                      color: AssetsConstants.mainColor,
                      size: AssetsConstants.defaultFontSize - 6.0,
                    ),
                    title: dashboard.value == null
                        ? ''
                        : getCustomContent({
                            'doanh thu:': dashboard.value!.totalRevenuesDaily
                          }),
                    subtitle: 'Doanh thu trong ngày',
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
      ),
    );
  }
}
