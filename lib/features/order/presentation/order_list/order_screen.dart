// ignore_for_file: unused_local_variable
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/custom_bottom_sheet.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../domain/models/order_model.dart';
import 'order_controller.dart';
import 'order_item.dart';

final searchByDate = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final orderDateFrom = StateProvider.autoDispose<String>(
  (ref) => getDateTimeNow(),
);

final orderDateTo = StateProvider.autoDispose<String>(
  (ref) => getDateTimeNow(),
);

@RoutePage()
class OrderScreen extends HookConsumerWidget {
  const OrderScreen({super.key});

  // fetch data
  Future<void> fetchData({
    required GetDataType getDatatype,
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<bool> isLoadMoreLoading,
    required ValueNotifier<List<OrderModel>> orders,
    required ValueNotifier<bool> isFetchingData,
    required String? filterSystemContent,
    required String? filterPartnerContent,
    required String? orderDateFrom,
    required String? orderDateTo,
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
              PagingModel(
                pageNumber: pageNumber.value,
                filterSystemContent: filterSystemContent,
                filterContent: filterPartnerContent,
                searchDateFrom: orderDateFrom,
                searchDateTo: orderDateTo,
              ),
              context,
            );

    isLastPage.value = ordersData.length < 10;
    if (getDatatype == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
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
    final size = MediaQuery.sizeOf(context);
    final orders = useState<List<OrderModel>>([]);
    final scrollController = useScrollController();
    final state = ref.watch(orderControllerProvider);
    final isFetchingData = useState(true);
    final systemStatus = ref.watch(filterSystemStatus);
    final partnerStatus = ref.watch(filterPartnerStatus);
    final dateFrom = ref.watch(orderDateFrom);
    final dateTo = ref.watch(orderDateTo);

    // searching
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(
          filterSystemContent: ref.read(filterSystemStatus).type,
          filterPartnerContent: ref.read(filterPartnerStatus).type,
          orderDateFrom: ref.read(orderDateFrom),
          orderDateTo: ref.read(orderDateTo),
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
            filterSystemContent: ref.read(filterSystemStatus).type,
            filterPartnerContent: ref.read(filterPartnerStatus).type,
            orderDateFrom: ref.read(orderDateFrom),
            orderDateTo: ref.read(orderDateTo),
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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Đơn Hàng',
        iconFirst: Icons.refresh_rounded,
        iconSecond: Icons.filter_list_alt,
        onCallBackFirst: () => fetchData(
          filterSystemContent: ref.read(filterSystemStatus).type,
          filterPartnerContent: ref.read(filterPartnerStatus).type,
          orderDateFrom: ref.read(orderDateFrom),
          orderDateTo: ref.read(orderDateTo),
          getDatatype: GetDataType.fetchdata,
          ref: ref,
          context: context,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          orders: orders,
          isFetchingData: isFetchingData,
        ),
        onCallBackSecond: () => showCustomBottomSheet(
          onCallback: () => fetchData(
            filterSystemContent: ref.read(filterSystemStatus).type,
            filterPartnerContent: ref.read(filterPartnerStatus).type,
            orderDateFrom: ref.read(orderDateFrom),
            orderDateTo: ref.read(orderDateTo),
            getDatatype: GetDataType.fetchdata,
            ref: ref,
            context: context,
            pageNumber: pageNumber,
            isLastPage: isLastPage,
            isLoadMoreLoading: isLoadMoreLoading,
            orders: orders,
            isFetchingData: isFetchingData,
          ),
          context: context,
          size: size,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          (state.isLoading && isLoadMoreLoading.value == false)
              ? const Center(
                  child: HomeShimmer(amount: 4),
                )
              : orders.value.isEmpty
                  ? const Align(
                      alignment: Alignment.topCenter,
                      child: EmptyBox(title: 'Đơn hàng trống'),
                    )
                  : Expanded(
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
                            onCallback: () => fetchData(
                              filterSystemContent:
                                  ref.read(filterSystemStatus).type,
                              filterPartnerContent:
                                  ref.read(filterPartnerStatus).type,
                              orderDateFrom: ref.read(orderDateFrom),
                              orderDateTo: ref.read(orderDateTo),
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
        ],
      ),
    );
  }
}
