import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';
import '../domain/repositories/home_repository.dart';
import 'statistical_card.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final statisticalValue = ref.watch(getStatisticalDataProvider);

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: const CustomeAppBar(
        backgroundColor: AssetsConstants.mainColor,
        title: LabelText(
          content: 'Trang chủ',
          size: AssetsConstants.defaultFontSize,
          color: AssetsConstants.whiteColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: AsyncValueWidget(
        value: statisticalValue,
        widgetLoading: const CircularProgressIndicator(),
        data: (statistical) => Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              StatisticalCard(
                backgroundColor: AssetsConstants.revenueBackground,
                contentColor: AssetsConstants.mainColor,
                icon: const Icon(
                  Icons.wallet_rounded,
                  color: AssetsConstants.mainColor,
                  size: AssetsConstants.defaultFontSize + 6.0,
                ),
                title: statistical.totalRevenue,
                subtitle: 'Doanh thu trong tuần',
              ),
              SizedBox(height: size.height * 0.02),
              StatisticalCard(
                backgroundColor: AssetsConstants.totalOrderBackground,
                contentColor: AssetsConstants.totalOrderContent,
                icon: const Icon(
                  Icons.shopping_bag,
                  color: AssetsConstants.totalOrderContent,
                  size: AssetsConstants.defaultFontSize + 6.0,
                ),
                title: statistical.totalOrder,
                subtitle: 'Tổng số đơn hàng trong tuần',
              )
            ],
          ),
        ),
      ),
    );
  }
}
