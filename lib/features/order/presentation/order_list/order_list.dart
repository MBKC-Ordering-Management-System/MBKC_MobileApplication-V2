// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../models/order_model.dart';
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
    required this.onCallbackLoadTabView,
  });

  final Function onCallbackLoadTabView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final scrollController = useScrollController();
    final orders = useState<List<OrderModel>>([]);
    final state = ref.watch(orderControllerProvider);

    // paging
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isShowNoMoreData = useState(false);
    final isLoadMoreLoading = useState(false);

    // handle refresh
    Future<void> fetchData({
      bool isLoadTabView = true,
      OrderStatusType type = OrderStatusType.preparing,
    }) async {
      if (isLoadTabView) {
        onCallbackLoadTabView(true);
      }

      pageNumber.value = 0;
      isLastPage.value = false;
      isShowNoMoreData.value = false;
      isLoadMoreLoading.value = false;
      pageNumber.value = pageNumber.value + 1;

      final ordersData =
          await ref.read(orderControllerProvider.notifier).getOrders(
                pageNumber.value,
                type,
              );

      isLastPage.value = ordersData.length < 10;
      isLoadMoreLoading.value = true;
      if (isLoadTabView) {
        onCallbackLoadTabView(false);
      }

      orders.value = ordersData;
    }

    // handle tab change
    ref.listen<OrderStatusType>(
      orderType,
      (_, state) => fetchData(type: state, isLoadTabView: false),
    );

    // handle scroll to load
    Future<void> loadMoreData() async {
      if (isLastPage.value) {
        if (isShowNoMoreData.value == false) {
          showSnackBar(
            context: context,
            content: 'Không còn dữ liệu',
            icon: const Icon(Icons.close),
            backgroundColor: AssetsConstants.mainColor,
            textColor: AssetsConstants.whiteColor,
          );
          isShowNoMoreData.value = true;
        }
        return;
      }

      pageNumber.value = pageNumber.value + 1;
      final ordersData =
          await ref.read(orderControllerProvider.notifier).getOrders(
                pageNumber.value,
                ref.read(orderType),
              );

      isLastPage.value = ordersData.length < 10;
      orders.value = orders.value + ordersData;
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
                  type: ref.read(orderType),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: AssetsConstants.defaultMargin,
                    ),
                    width: size.width * 0.9,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      color: AssetsConstants.mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(FontAwesomeIcons.boxArchive),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        const LabelText(
                          content: 'Đơn hàng đang trống',
                          size: AssetsConstants.defaultFontSize,
                          color: AssetsConstants.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Expanded(
                child: RefreshIndicator(
                  backgroundColor: AssetsConstants.revenueBackground,
                  color: AssetsConstants.mainColor,
                  onRefresh: () async => await fetchData(
                    type: ref.read(orderType),
                  ),
                  child: ListView.separated(
                    itemCount: orders.value.length + 1,
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AssetsConstants.defaultPadding - 10.0,
                    ),
                    separatorBuilder: (_, __) =>
                        Divider(height: size.height * 0.015),
                    itemBuilder: (_, index) {
                      if (index == orders.value.length) {
                        return (state.isLoading && isLoadMoreLoading.value)
                            ? Container(
                                padding: const EdgeInsets.only(
                                  bottom: AssetsConstants.defaultPadding - 10.0,
                                ),
                                child: const Align(
                                  child: CircularProgressIndicator(
                                    color: AssetsConstants.mainColor,
                                    backgroundColor:
                                        AssetsConstants.revenueBackground,
                                  ),
                                ),
                              )
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
