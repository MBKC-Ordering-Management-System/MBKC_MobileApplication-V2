import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/order_status_type.dart';
import 'order_controller.dart';
import 'order_list.dart';

final List<OrderStatusType> items = [
  OrderStatusType.preparing,
  OrderStatusType.ready,
  OrderStatusType.delivering,
  OrderStatusType.delivered,
  OrderStatusType.cancelled,
];

final orderType = StateProvider<OrderStatusType>(
  (ref) => OrderStatusType.preparing,
);

@RoutePage()
class OrderScreen extends HookConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final state = ref.watch(orderControllerProvider);
    final isFirstLoad = useState(true);
    final nowIndex = items.indexOf(ref.watch(orderType));

    // UI
    return Scaffold(
      appBar: const CustomAppBar(title: 'Đơn Hàng'),
      body: Column(
        children: [
          (state.isLoading && isFirstLoad.value)
              ? const TabViewShimmer(amount: 3)
              : Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AssetsConstants.subtitleColor.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  height: size.height * 0.06,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () => ref.read(orderType.notifier).update(
                            (state) => items[index],
                          ),
                      child: AnimatedContainer(
                        duration: const Duration(microseconds: 2000),
                        margin: const EdgeInsets.all(
                          AssetsConstants.defaultMargin - 4.0,
                        ),
                        width: size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: nowIndex == index
                                ? AssetsConstants.mainColor
                                : AssetsConstants.mainColor,
                          ),
                          color: nowIndex == index
                              ? AssetsConstants.mainColor
                              : AssetsConstants.whiteColor,
                        ),
                        child: Align(
                          child: LabelText(
                            color: nowIndex == index
                                ? AssetsConstants.whiteColor
                                : AssetsConstants.mainColor,
                            content: items[index].type,
                            size: AssetsConstants.defaultFontSize - 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          OrderList(
            isFirstLoad: isFirstLoad,
          ),
        ],
      ),
    );
  }
}
