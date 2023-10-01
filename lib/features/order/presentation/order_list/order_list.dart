import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/models/order_model.dart';
import '../../../../utils/commons/widgets/empty_box.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/order_status_type.dart';
import '../../../../utils/extensions/extensions_export.dart';
import 'order_controller.dart';
import 'order_item.dart';
import 'order_screen.dart';

class OrderList extends HookConsumerWidget {
  const OrderList({
    super.key,
    required this.isFirstLoad,
  });

  final ValueNotifier<bool> isFirstLoad;

  // handle refresh
  Future<void> fetchData({
    OrderStatusType type = OrderStatusType.preparing,
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<bool> isLoadMoreLoading,
    required ValueNotifier<List<OrderModel>> orders,
  }) async {
    pageNumber.value = 0;
    isLastPage.value = false;
    isLoadMoreLoading.value = false;
    pageNumber.value = pageNumber.value + 1;
    final ordersData =
        await ref.read(orderControllerProvider.notifier).getOrders(
              pageNumber.value,
              type,
              context,
            );

    isLastPage.value = ordersData.length < 10;
    isLoadMoreLoading.value = true;
    if (isFirstLoad.value) {
      isFirstLoad.value = !isFirstLoad.value;
    }

    orders.value = ordersData;
  }

  //  scroll to load
  Future<void> loadMoreData({
    required BuildContext context,
    required WidgetRef ref,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<List<OrderModel>> orders,
  }) async {
    if (isLastPage.value) {
      return;
    }

    pageNumber.value = pageNumber.value + 1;
    final ordersData =
        await ref.read(orderControllerProvider.notifier).getOrders(
              pageNumber.value,
              ref.read(orderType),
              context,
            );

    isLastPage.value = ordersData.length < 10;
    orders.value = orders.value + ordersData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final scrollController = useScrollController();
    final orders = useState<List<OrderModel>>([]);
    final state = ref.watch(orderControllerProvider);

    // paging
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // handle tab change
    ref.listen<OrderStatusType>(
      orderType,
      (_, state) => fetchData(
        context: context,
        type: state,
        ref: ref,
        pageNumber: pageNumber,
        isLastPage: isLastPage,
        isLoadMoreLoading: isLoadMoreLoading,
        orders: orders,
      ),
    );

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(
          context: context,
          ref: ref,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          orders: orders,
        );
      });

      scrollController.onScrollEndsListener(
        () {
          loadMoreData(
            context: context,
            ref: ref,
            isLastPage: isLastPage,
            pageNumber: pageNumber,
            orders: orders,
          );
        },
      );

      return scrollController.dispose;
    }, const []);

    // UI
    return (state.isLoading && isLoadMoreLoading.value == false)
        ? const Center(
            child: HomeShimmer(amount: 4),
          )
        : orders.value.isEmpty
            ? RefreshIndicator(
                backgroundColor: AssetsConstants.revenueBackground,
                color: AssetsConstants.mainColor,
                onRefresh: () async => await fetchData(
                  context: context,
                  type: ref.read(orderType),
                  ref: ref,
                  pageNumber: pageNumber,
                  isLastPage: isLastPage,
                  isLoadMoreLoading: isLoadMoreLoading,
                  orders: orders,
                ),
                child: const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: EmptyBox(title: 'Đơn hàng đang trống'),
                ),
              )
            : Expanded(
                child: RefreshIndicator(
                  backgroundColor: AssetsConstants.revenueBackground,
                  color: AssetsConstants.mainColor,
                  onRefresh: () async => await fetchData(
                    context: context,
                    type: ref.read(orderType),
                    ref: ref,
                    pageNumber: pageNumber,
                    isLastPage: isLastPage,
                    isLoadMoreLoading: isLoadMoreLoading,
                    orders: orders,
                  ),
                  child: ListView.builder(
                    itemCount: orders.value.length + 1,
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AssetsConstants.defaultPadding - 10.0,
                    ),
                    itemBuilder: (_, index) {
                      if (index == orders.value.length) {
                        if (state.isLoading) {
                          return const CustomCircular();
                        }
                        return isLastPage.value
                            ? const NoMoreContent()
                            : Container();
                      }
                      return OrderItem(
                        order: orders.value[index],
                        orderType: orders.value[index].status,
                      );
                    },
                  ),
                ),
              );
  }
}
