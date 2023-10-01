// ignore_for_file: unused_local_variable
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/widgets/empty_box.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../domain/models/banking_account_model.dart';
import 'banking_account_controller.dart';
import 'banking_account_item.dart';

@RoutePage()
class BankingAccountScreen extends HookConsumerWidget {
  const BankingAccountScreen({super.key});

  // handle refresh
  Future<void> fetchData({
    required GetDataType type,
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<bool> isLoadMoreLoading,
    required ValueNotifier<List<BankingAccountModel>> accounts,
  }) async {
    if (type == GetDataType.fetchdata) {
      pageNumber.value = 0;
      isLastPage.value = false;
      isLoadMoreLoading.value = false;
    }

    if (isLastPage.value) {
      return;
    }

    pageNumber.value = pageNumber.value + 1;
    final accountsData = await ref
        .read(bankingAccountControllerProvider.notifier)
        .getBankingAccounts(PagingModel(pageNumber: pageNumber.value), context);

    isLastPage.value = accountsData.length < 10;
    if (type == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
      accounts.value = accountsData;
      return;
    }

    accounts.value = accounts.value + accountsData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final accounts = useState<List<BankingAccountModel>>([]);
    final scrollController = useScrollController();
    final state = ref.watch(bankingAccountControllerProvider);

    // paging
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // first load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        fetchData(
          type: GetDataType.fetchdata,
          context: context,
          ref: ref,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          accounts: accounts,
        );
      });

      scrollController.onScrollEndsListener(
        () {
          fetchData(
            type: GetDataType.loadmore,
            context: context,
            ref: ref,
            pageNumber: pageNumber,
            isLastPage: isLastPage,
            isLoadMoreLoading: isLoadMoreLoading,
            accounts: accounts,
          );
        },
      );

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tài Khoản Ngân Hàng',
        backButtonColor: AssetsConstants.whiteColor,
      ),
      body: (state.isLoading)
          ? const Center(
              child: HomeShimmer(amount: 4),
            )
          : accounts.value.isEmpty
              ? const Align(
                  alignment: Alignment.topCenter,
                  child: EmptyBox(title: 'Không có tài khoản'),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AssetsConstants.defaultPadding - 8.0,
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: accounts.value.length + 1,
                    itemBuilder: (_, index) {
                      if (index == accounts.value.length) {
                        if (state.isLoading) {
                          return const CustomCircular();
                        }
                        return isLastPage.value
                            ? const NoMoreContent()
                            : Container();
                      }
                      return BankingAccountItem(
                        isFirst: index == 0 ? true : false,
                        account: accounts.value[index],
                        onCallBack: () => fetchData(
                          type: GetDataType.fetchdata,
                          ref: ref,
                          context: context,
                          pageNumber: pageNumber,
                          isLastPage: isLastPage,
                          isLoadMoreLoading: isLoadMoreLoading,
                          accounts: accounts,
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: SizedBox(
        width: size.width * 0.14,
        height: size.height * 0.07,
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: AssetsConstants.defaultFontSize + 10.0,
          ),
        ),
      ),
    );
  }
}
