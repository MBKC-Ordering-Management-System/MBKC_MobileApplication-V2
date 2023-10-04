import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../domain/models/transaction_model.dart';
import 'transaction_controller.dart';
import 'transaction_item.dart';
import 'transaction_type_item.dart';

final transactionType = StateProvider.autoDispose<TransactionType>(
  (ref) => TransactionType.all,
);

@RoutePage()
class TransactionScreen extends HookConsumerWidget {
  const TransactionScreen({super.key});

  // handle refresh
  Future<void> fetchData({
    required GetDataType getDatatype,
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<bool> isLoadMoreLoading,
    required ValueNotifier<List<TransactionModel>> transactions,
    required ValueNotifier<bool> isFetchingData,
    required ValueNotifier<bool> isFirstLoad,
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
    final accountsData =
        await ref.read(transactionControllerProvider.notifier).getTransactions(
              PagingModel(pageNumber: pageNumber.value),
              context,
              ref.read(transactionType),
            );

    isLastPage.value = accountsData.length < 10;
    if (getDatatype == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
      // here
      if (isFirstLoad.value) {
        isFirstLoad.value = !isFirstLoad.value;
      }
      transactions.value = accountsData;
      isFetchingData.value = false;
      return;
    }

    isFetchingData.value = false;
    transactions.value = transactions.value + accountsData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final transactions = useState<List<TransactionModel>>([]);
    // final dateFrom = useState(getDateTimeNow());
    // final dateTo = useState(getDateTimeNow());
    final isFirstLoad = useState(true);
    final scrollController = useScrollController();
    final isFetchingData = useState(true);
    final state = ref.watch(transactionControllerProvider);
    final type = ref.watch(transactionType);

    // paging
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // listen change type
    ref.listen<TransactionType>(
      transactionType,
      (_, state) => fetchData(
        isFirstLoad: isFirstLoad,
        getDatatype: GetDataType.fetchdata,
        ref: ref,
        context: context,
        pageNumber: pageNumber,
        isLastPage: isLastPage,
        isLoadMoreLoading: isLoadMoreLoading,
        transactions: transactions,
        isFetchingData: isFetchingData,
      ),
    );

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(
          isFirstLoad: isFirstLoad,
          getDatatype: GetDataType.fetchdata,
          context: context,
          ref: ref,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          transactions: transactions,
          isFetchingData: isFetchingData,
        );
      });

      scrollController.onScrollEndsListener(
        () {
          fetchData(
            isFirstLoad: isFirstLoad,
            getDatatype: GetDataType.loadmore,
            context: context,
            ref: ref,
            pageNumber: pageNumber,
            isLastPage: isLastPage,
            isLoadMoreLoading: isLoadMoreLoading,
            transactions: transactions,
            isFetchingData: isFetchingData,
          );
        },
      );

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: const CustomAppBar(
        backButtonColor: AssetsConstants.whiteColor,
        title: 'Lịch sử giao dịch',
      ),
      body: (state.isLoading & isFirstLoad.value)
          ? const HomeShimmer(amount: 4)
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AssetsConstants.defaultPadding - 10.0,
              ),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.01),
                  const SearchTimeBox(
                    title: 'Tra cứu giao dịch',
                    icon: Icons.insert_chart_outlined,
                    contentColor: AssetsConstants.blackColor,
                    backGroundColor: AssetsConstants.scaffoldColor,
                    borderColor: AssetsConstants.borderColor,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AssetsConstants.defaultPadding - 10.0,
                    ),
                    height: size.height * 0.69,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AssetsConstants.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        AssetsConstants.defaultBorder,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => ref
                                  .read(transactionType.notifier)
                                  .update((state) => TransactionType.all),
                              child: TransactionTypeItem(
                                title: 'Tất cả',
                                isActive: type == TransactionType.all,
                              ),
                            ),
                            InkWell(
                              onTap: () => ref
                                  .read(transactionType.notifier)
                                  .update((state) => TransactionType.moneyin),
                              child: TransactionTypeItem(
                                title: 'Tiền vào',
                                isActive: type == TransactionType.moneyin,
                              ),
                            ),
                            InkWell(
                              onTap: () => ref
                                  .read(transactionType.notifier)
                                  .update((state) => TransactionType.moneyout),
                              child: TransactionTypeItem(
                                title: 'Tiền ra',
                                isActive: type == TransactionType.moneyout,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        (state.isLoading && isLoadMoreLoading.value == false)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: transactions.value.length + 1,
                                  itemBuilder: (_, index) {
                                    if (index == transactions.value.length) {
                                      if (state.isLoading) {
                                        return const CustomCircular();
                                      }
                                      return isLastPage.value
                                          ? const NoMoreContent()
                                          : Container();
                                    }
                                    return TransactionItem(
                                      transaction: transactions.value[index],
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
