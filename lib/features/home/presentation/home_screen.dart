import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../utils/commons/functions/functions_common_export.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';
import '../domain/models/statistical_model.dart';
import '../domain/repositories/home_repository.dart';
import 'statistical_card.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  // handle refresh
  Future<void> fetchData({
    required WidgetRef ref,
    required ValueNotifier<bool> isLoading,
    required ValueNotifier<StatisticalModel?> statistical,
  }) async {
    isLoading.value = true;

    final statisticalData = await ref.watch(
      getStatisticalDataProvider.future,
    );

    statistical.value = statisticalData;
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final isLoading = useState(false);
    final statistical = useState<StatisticalModel?>(null);

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(ref: ref, isLoading: isLoading, statistical: statistical);
      });

      () async {
        await delay(true);
      };

      FlutterNativeSplash.remove();
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: const CustomeAppBar(title: 'Trang Chủ'),
      body: isLoading.value
          ? const Center(
              child: HomeShimmer(amount: 2),
            )
          : RefreshIndicator(
              color: AssetsConstants.mainColor,
              backgroundColor: AssetsConstants.revenueBackground,
              onRefresh: () => fetchData(
                ref: ref,
                isLoading: isLoading,
                statistical: statistical,
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      StatisticalCard(
                        backgroundColor: AssetsConstants.revenueBackground,
                        contentColor: AssetsConstants.mainColor,
                        icon: const Icon(
                          Icons.wallet_rounded,
                          color: AssetsConstants.mainColor,
                          size: AssetsConstants.defaultFontSize - 6.0,
                        ),
                        title: '${statistical.value?.totalRevenue}đ',
                        subtitle: 'Doanh thu trong tuần',
                      ),
                      SizedBox(height: size.height * 0.02),
                      StatisticalCard(
                        backgroundColor: AssetsConstants.totalOrderBackground,
                        contentColor: AssetsConstants.totalOrderContent,
                        icon: const Icon(
                          Icons.shopping_bag,
                          color: AssetsConstants.totalOrderContent,
                          size: AssetsConstants.defaultFontSize - 6.0,
                        ),
                        title: '${statistical.value?.totalOrder}',
                        subtitle: 'Tổng số đơn hàng trong tuần',
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
