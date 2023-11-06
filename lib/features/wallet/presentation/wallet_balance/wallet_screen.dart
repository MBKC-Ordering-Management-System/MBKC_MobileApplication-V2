// ignore_for_file: unused_local_variable
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../domain/models/transaction_model.dart';
import 'bottom_sheet_searching.dart';
import 'transaction_controller.dart';
import 'transaction_item.dart';

final transactionDateFrom = StateProvider.autoDispose<String>(
  (ref) => getDateTimeNow(),
);

final transactionDateTo = StateProvider.autoDispose<String>(
  (ref) => getDateTimeNow(),
);

@RoutePage()
class WalletScreen extends HookConsumerWidget {
  const WalletScreen({super.key});

  // fetch data
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
    required String? filterType,
    required String? transactionDateFrom,
    required String? transactionDateTo,
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
    final transactionsData = await ref
        .read(transactionControllerProvider.notifier)
        .getMoneyExchanges(
          PagingModel(
            pageNumber: pageNumber.value,
          ),
          context,
        );

    isLastPage.value = transactionsData.length < 10;
    if (getDatatype == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
      // here
      if (isFirstLoad.value) {
        isFirstLoad.value = !isFirstLoad.value;
      }

      transactions.value = transactionsData;
      isFetchingData.value = false;
      return;
    }

    isFetchingData.value = false;
    transactions.value = transactions.value + transactionsData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final transactions = useState<List<TransactionModel>>([]);
    final isFirstLoad = useState(true);
    final scrollController = useScrollController();
    final isFetchingData = useState(true);
    final state = ref.watch(transactionControllerProvider);
    final moneyExchangeType = ref.watch(moneyExchangeTypeProvider);
    final dateFrom = ref.watch(transactionDateFrom);
    final dateTo = ref.watch(transactionDateTo);

    // paging
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(
          filterType: ref.read(moneyExchangeTypeProvider).type,
          transactionDateFrom: ref.read(transactionDateFrom),
          transactionDateTo: ref.read(transactionDateTo),
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
            filterType: ref.read(moneyExchangeTypeProvider).type,
            transactionDateFrom: ref.read(transactionDateFrom),
            transactionDateTo: ref.read(transactionDateTo),
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

      return () {
        scrollController.dispose;
      };
    }, const []);

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: CustomAppBar(
        title: 'Ví',
        iconFirst: Icons.refresh_rounded,
        iconSecond: Icons.filter_list_alt,
        backButtonColor: AssetsConstants.whiteColor,
        onCallBackFirst: () => fetchData(
          filterType: ref.read(moneyExchangeTypeProvider).type,
          transactionDateFrom: ref.read(transactionDateFrom),
          transactionDateTo: ref.read(transactionDateTo),
          isFirstLoad: isFirstLoad,
          getDatatype: GetDataType.fetchdata,
          context: context,
          ref: ref,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          transactions: transactions,
          isFetchingData: isFetchingData,
        ),
        onCallBackSecond: () => showBottomSheetSearching(
          context: context,
          size: size,
          onCallback: () {
            fetchData(
              filterType: ref.read(moneyExchangeTypeProvider).type,
              transactionDateFrom: ref.read(transactionDateFrom),
              transactionDateTo: ref.read(transactionDateTo),
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
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AssetsConstants.defaultPadding - 6.0,
            ),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                StatisticalCard(
                  backgroundColor: AssetsConstants.revenueBackground,
                  contentColor: AssetsConstants.mainColor,
                  icon: const Icon(
                    Icons.wallet,
                    color: AssetsConstants.mainColor,
                  ),
                  title: getCustomContent({'Giá:': 5000000}),
                  subtitle: 'Số dư tài khoản',
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AssetsConstants.defaultPadding - 10.0,
                  ),
                  height: size.height * 0.66,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AssetsConstants.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      AssetsConstants.defaultBorder,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.01),
                      (state.isLoading && isLoadMoreLoading.value == false)
                          ? Center(
                              child: LottieBuilder.asset(
                                AssetsConstants.lottieLoadingTrans,
                                width: size.width * 0.5,
                                height: size.height * 0.5,
                              ),
                            )
                          : transactions.value.isEmpty
                              ? const EmptyBox(title: 'Không có giao dịch')
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
                                      return InkWell(
                                        onTap: () => context.router.push(
                                          TransactionDetailScreenRoute(
                                            transaction:
                                                transactions.value[index],
                                          ),
                                        ),
                                        child: TransactionItem(
                                          transaction:
                                              transactions.value[index],
                                        ),
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
        ),
      ),
    );
  }
}
