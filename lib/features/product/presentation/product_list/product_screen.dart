import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../domain/models/product_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import 'bottom_sheet_filter.dart';
import 'bottom_sheet_sort.dart';
import 'filter_sort_box.dart';
import 'product_controller.dart';
import 'product_item.dart';
import 'product_shimmer.dart';
import 'search_box.dart';

@RoutePage()
class ProductScreen extends HookConsumerWidget {
  const ProductScreen({super.key});

  // fetch data
  Future<void> fetchData({
    required GetDataType getDatatype,
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<bool> isLoadMoreLoading,
    required ValueNotifier<List<ProductModel>> products,
    required ValueNotifier<bool> isFetchingData,
    required ValueNotifier<bool> isFirstLoad,
    required String? searchContent,
    required String? filterContent,
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
    final productsData =
        await ref.read(productControllerProvider.notifier).getProducts(
              PagingModel(
                pageNumber: pageNumber.value,
                searchContent: searchContent,
                filterContent: filterContent,
              ),
              context,
            );

    isLastPage.value = productsData.length < 10;
    if (getDatatype == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
      // here
      if (isFirstLoad.value) {
        isFirstLoad.value = !isFirstLoad.value;
      }

      products.value = productsData;
      isFetchingData.value = false;
      return;
    }

    isFetchingData.value = false;
    products.value = products.value + productsData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final products = useState<List<ProductModel>>([]);
    final scrollController = useScrollController();
    final state = ref.watch(productControllerProvider);
    final isFetchingData = useState(true);
    final isFirstLoad = useState(true);

    // searching
    final searchContent = useTextEditingController();
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // first build(init state)
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchData(
          filterContent: ref.read(optionFilterProvider)?.type,
          searchContent: searchContent.text.trim(),
          getDatatype: GetDataType.fetchdata,
          ref: ref,
          context: context,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          products: products,
          isFetchingData: isFetchingData,
          isFirstLoad: isFirstLoad,
        );
      });

      scrollController.onScrollEndsListener(
        () async {
          await fetchData(
            filterContent: ref.read(optionFilterProvider)?.type,
            searchContent: searchContent.text.trim(),
            getDatatype: GetDataType.loadmore,
            ref: ref,
            context: context,
            pageNumber: pageNumber,
            isLastPage: isLastPage,
            isLoadMoreLoading: isLoadMoreLoading,
            products: products,
            isFetchingData: isFetchingData,
            isFirstLoad: isFirstLoad,
          );
        },
      );

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: CustomAppBar(
        title: 'Sản Phẩm',
        iconFirst: Icons.refresh_rounded,
        onCallBackFirst: () => fetchData(
          filterContent: ref.read(optionFilterProvider)?.type,
          searchContent: searchContent.text.trim(),
          getDatatype: GetDataType.fetchdata,
          ref: ref,
          context: context,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          products: products,
          isFetchingData: isFetchingData,
          isFirstLoad: isFirstLoad,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AssetsConstants.defaultPadding - 8.0,
        ).copyWith(
          top: AssetsConstants.defaultPadding - 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Consumer(
                  builder: (_, ref, __) => InkWell(
                    onTap: () => bottomSheetFilter(
                      context: context,
                      size: size,
                      onCallback: () => fetchData(
                        filterContent: ref.read(optionFilterProvider)?.type,
                        getDatatype: GetDataType.fetchdata,
                        ref: ref,
                        context: context,
                        pageNumber: pageNumber,
                        isLastPage: isLastPage,
                        isLoadMoreLoading: isLoadMoreLoading,
                        products: products,
                        isFetchingData: isFetchingData,
                        isFirstLoad: isFirstLoad,
                        searchContent: searchContent.text.trim(),
                      ),
                    ),
                    child: FilterSortBox(
                      content: ref.watch(optionFilterProvider) != null
                          ? getTitleProductType(
                              ref.watch(optionFilterProvider)!)
                          : 'Loại',
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                InkWell(
                  onTap: () => bottomSheetSort(
                    context: context,
                    size: size,
                    onCallback: () => fetchData(
                      filterContent: ref.read(optionFilterProvider)?.type,
                      getDatatype: GetDataType.fetchdata,
                      ref: ref,
                      context: context,
                      pageNumber: pageNumber,
                      isLastPage: isLastPage,
                      isLoadMoreLoading: isLoadMoreLoading,
                      products: products,
                      isFetchingData: isFetchingData,
                      isFirstLoad: isFirstLoad,
                      searchContent: searchContent.text.trim(),
                    ),
                  ),
                  child: FilterSortBox(
                    content: ref.watch(optionSortProvider)?.type ?? 'Giá',
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.015),
            SearchBox(
              controller: searchContent,
              onCallBack: (val) {
                fetchData(
                  filterContent: ref.read(optionFilterProvider)?.type,
                  searchContent: searchContent.text.trim(),
                  getDatatype: GetDataType.fetchdata,
                  ref: ref,
                  context: context,
                  pageNumber: pageNumber,
                  isLastPage: isLastPage,
                  isLoadMoreLoading: isLoadMoreLoading,
                  products: products,
                  isFetchingData: isFetchingData,
                  isFirstLoad: isFirstLoad,
                );
              },
            ),
            Container(
              padding: const EdgeInsets.only(
                top: AssetsConstants.defaultPadding - 18.0,
              ),
              decoration: const BoxDecoration(),
            ),
            (state.isLoading && isLoadMoreLoading.value == false)
                ? const ProductShimmer(amount: 4)
                : products.value.isEmpty
                    ? const EmptyBox(title: 'Không có sản phẩm')
                    : Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: products.value.length + 1,
                          itemBuilder: (_, index) {
                            if (index == products.value.length) {
                              if (state.isLoading) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                    top: AssetsConstants.defaultMargin,
                                  ),
                                  child: const CustomCircular(),
                                );
                              }
                              return isLastPage.value
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        top: AssetsConstants.defaultMargin,
                                      ),
                                      child: const NoMoreContent(),
                                    )
                                  : Container();
                            }

                            return InkWell(
                              onTap: () => context.router.push(
                                ProductDetailScreenRoute(
                                  productId: products.value[index].productId,
                                ),
                              ),
                              child: ProductItem(
                                product: products.value[index],
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
