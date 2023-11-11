import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../models/wallet_model.dart';
import '../../../utils/commons/functions/functions_common_export.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';
import '../../money_exchange/presentation/money_exchange_list/wallet_controller.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  // fetch data
  Future<void> fetchData({
    required ValueNotifier<WalletModel?> wallet,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final response =
        await ref.read(walletControllerProvider.notifier).getBalance(context);

    wallet.value = response;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final wallet = useState<WalletModel?>(null);
    final state = ref.watch(walletControllerProvider);

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(wallet: wallet, ref: ref, context: context);
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
        onCallBackFirst: () =>
            fetchData(wallet: wallet, ref: ref, context: context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AssetsConstants.defaultPadding - 6.0,
        ),
        child: wallet.value == null && state.isLoading == false
            ? const HomeShimmer(amount: 2)
            : Column(
                children: [
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
                    title: wallet.value == null
                        ? ''
                        : getCustomContent(
                            {'Giá:': wallet.value!.totalRevenueDaily}),
                    subtitle: 'Doanh thu trong ngày',
                  ),
                  SizedBox(height: size.height * 0.02),
                  StatisticalCard(
                    loadingColor: AssetsConstants.totalOrderContent,
                    state: state,
                    backgroundColor: AssetsConstants.totalOrderBackground,
                    contentColor: AssetsConstants.totalOrderContent,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: AssetsConstants.totalOrderContent,
                      size: AssetsConstants.defaultFontSize - 6.0,
                    ),
                    title: wallet.value == null
                        ? ''
                        : '${wallet.value!.toTalOrderDaily}',
                    subtitle: 'Tổng số đơn hàng trong ngày',
                  ),
                ],
              ),
      ),
    );
  }
}
