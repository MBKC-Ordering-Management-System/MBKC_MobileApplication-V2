import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../models/order_model.dart';
import '../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../utils/constants/asset_constant.dart';
import '../../../utils/enums/order_status_type.dart';
import '../../../utils/extensions/extensions_export.dart';
import '../domain/repositories/order_repository.dart';
import 'order_list.dart';

final List<OrderStatusType> items = [
  OrderStatusType.preparing,
  OrderStatusType.ready,
  OrderStatusType.delivering,
  OrderStatusType.delivered,
  OrderStatusType.cancelled,
];

@RoutePage()
class OrderScreen extends HookConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final currentIndex = useState(0);
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoading = useState(false);
    final isLoadMoreLoading = useState(false);
    final scrollController = useScrollController();
    final orders = useState<List<OrderModel>>([]);

    // handle refresh
    Future<void> fetchData() async {
      pageNumber.value = 0;
      isLastPage.value = false;
      isLoading.value = true;

      final ordersData = await ref.watch(
        getOrdersProvider.future,
      );

      orders.value = ordersData;
      isLoading.value = false;
    }

    // handle scroll to load
    Future<void> loadMoreData() async {
      if (isLastPage.value) {
        return;
      }

      isLoadMoreLoading.value = true;
      pageNumber.value = pageNumber.value + 1;
      final ordersData = await ref.watch(
        getOrdersProvider.future,
      );
      isLastPage.value = ordersData.length < 5;
      orders.value = orders.value + ordersData;
      isLoadMoreLoading.value = false;
    }

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData();
      });

      scrollController.onScrollEndsListener(
        () {
          loadMoreData();
        },
      );

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AssetsConstants.mainColor,
        centerTitle: true,
        title: const LabelText(
          content: 'Đơn hàng',
          size: AssetsConstants.defaultFontSize,
          color: AssetsConstants.whiteColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: isLoading.value
          ? const Center(
              child: HomeShimmer(),
            )
          : RefreshIndicator(
              onRefresh: fetchData,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.06,
                    width: double.infinity,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () => currentIndex.value = index,
                        child: AnimatedContainer(
                          duration: const Duration(microseconds: 2000),
                          margin: const EdgeInsets.all(
                            AssetsConstants.defaultMargin - 4.0,
                          ),
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: currentIndex.value == index
                                  ? AssetsConstants.mainColor
                                  : AssetsConstants.mainColor,
                            ),
                            color: currentIndex.value == index
                                ? AssetsConstants.mainColor
                                : AssetsConstants.whiteColor,
                          ),
                          child: Align(
                            child: LabelText(
                              color: currentIndex.value == index
                                  ? AssetsConstants.whiteColor
                                  : AssetsConstants.mainColor,
                              content: items[index].type,
                              size: AssetsConstants.defaultFontSize - 8.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  OrderList(
                    orders: orders.value
                        .where((element) =>
                            element.status == items[currentIndex.value])
                        .toList(),
                    orderType: items[currentIndex.value],
                  ),
                  SizedBox(height: size.height * 0.01),
                  if (isLoadMoreLoading.value)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
    );
  }
}
