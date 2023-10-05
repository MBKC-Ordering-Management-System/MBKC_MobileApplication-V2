import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/order_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
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
  void fetchData({
    OrderStatusType ordertype = OrderStatusType.preparing,
    required GetDataType getDatatype,
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<bool> isLoadMoreLoading,
    required ValueNotifier<List<OrderModel>> orders,
    required ValueNotifier<bool> isFetchingData,
  }) async {
    if (getDatatype == GetDataType.loadmore && isFetchingData.value) {
      return;
    }

    if (getDatatype == GetDataType.fetchdata) {
      pageNumber.value = 0;
      isLastPage.value = false;
      isLoadMoreLoading.value = false;
    }

    if (isLastPage.value) {
      return;
    }

    isFetchingData.value = true;
    pageNumber.value = pageNumber.value + 1;
    final ordersData =
        await ref.read(orderControllerProvider.notifier).getOrders(
              pageNumber.value,
              ordertype,
              context,
            );

    isLastPage.value = ordersData.length < 10;
    if (getDatatype == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
      if (isFirstLoad.value) {
        isFirstLoad.value = !isFirstLoad.value;
      }
      orders.value = ordersData;
      isFetchingData.value = false;
      return;
    }

    isFetchingData.value = false;
    orders.value = orders.value + ordersData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final scrollController = useScrollController();
    final orders = useState<List<OrderModel>>([]);
    final isFetchingData = useState(true);
    final state = ref.watch(orderControllerProvider);

    // paging
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // handle tab change
    ref.listen<OrderStatusType>(
      orderType,
      (_, state) => fetchData(
        ordertype: state,
        getDatatype: GetDataType.fetchdata,
        ref: ref,
        context: context,
        pageNumber: pageNumber,
        isLastPage: isLastPage,
        isLoadMoreLoading: isLoadMoreLoading,
        orders: orders,
        isFetchingData: isFetchingData,
      ),
    );

    // handle refresh icon
    ref.listen<bool>(
      refresh,
      (_, state) => fetchData(
        ordertype: ref.read(orderType),
        getDatatype: GetDataType.fetchdata,
        ref: ref,
        context: context,
        pageNumber: pageNumber,
        isLastPage: isLastPage,
        isLoadMoreLoading: isLoadMoreLoading,
        orders: orders,
        isFetchingData: isFetchingData,
      ),
    );

    // handle search by date
    ref.listen<bool>(
      searchByDate,
      (_, state) => fetchData(
        ordertype: ref.read(orderType),
        getDatatype: GetDataType.fetchdata,
        ref: ref,
        context: context,
        pageNumber: pageNumber,
        isLastPage: isLastPage,
        isLoadMoreLoading: isLoadMoreLoading,
        orders: orders,
        isFetchingData: isFetchingData,
      ),
    );

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(
          getDatatype: GetDataType.fetchdata,
          ref: ref,
          context: context,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          orders: orders,
          isFetchingData: isFetchingData,
        );
      });

      scrollController.onScrollEndsListener(
        () {
          fetchData(
            ordertype: ref.read(orderType),
            getDatatype: GetDataType.loadmore,
            ref: ref,
            context: context,
            pageNumber: pageNumber,
            isLastPage: isLastPage,
            isLoadMoreLoading: isLoadMoreLoading,
            orders: orders,
            isFetchingData: isFetchingData,
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
                onRefresh: () async => fetchData(
                  ordertype: ref.read(orderType),
                  getDatatype: GetDataType.fetchdata,
                  ref: ref,
                  context: context,
                  pageNumber: pageNumber,
                  isLastPage: isLastPage,
                  isLoadMoreLoading: isLoadMoreLoading,
                  orders: orders,
                  isFetchingData: isFetchingData,
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
                  onRefresh: () async => fetchData(
                    ordertype: ref.read(orderType),
                    getDatatype: GetDataType.fetchdata,
                    ref: ref,
                    context: context,
                    pageNumber: pageNumber,
                    isLastPage: isLastPage,
                    isLoadMoreLoading: isLoadMoreLoading,
                    orders: orders,
                    isFetchingData: isFetchingData,
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
                        onCallback: () => fetchData(
                          ordertype: ref.read(orderType),
                          getDatatype: GetDataType.fetchdata,
                          ref: ref,
                          context: context,
                          pageNumber: pageNumber,
                          isLastPage: isLastPage,
                          isLoadMoreLoading: isLoadMoreLoading,
                          orders: orders,
                          isFetchingData: isFetchingData,
                        ),
                      );
                    },
                  ),
                ),
              );
  }
}
