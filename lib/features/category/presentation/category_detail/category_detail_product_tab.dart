import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/commons/functions/string_utils.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../domain/models/product_model.dart';
import 'product_list/bottom_sheet_filter.dart';
import 'product_list/bottom_sheet_sort.dart';
import 'product_list/product_controller.dart';
import 'product_list/product_item.dart';
import 'product_list/product_search_box.dart';
import 'product_list/product_shimmer.dart';

class CategoryDetailProductTab extends HookConsumerWidget {
  const CategoryDetailProductTab(
    this.categoryId,
    this.categoryType, {
    super.key,
  });
  final int categoryId;
  final CategoryType categoryType;

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
    required String? searchContent,
    required String? filterContent,
    required String? sortContent,
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
                sortContent: sortContent,
              ),
              context,
              categoryId,
            );

    isLastPage.value = productsData.length < 10;
    if (getDatatype == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
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

    // searching
    final searchContent = useTextEditingController();
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isLoadMoreLoading = useState(false);

    // first build(init state)
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchData(
          filterContent: categoryType == CategoryType.normal
              ? ref.read(optionFilterProvider)?.type
              : categoryType.type,
          sortContent: ref.read(optionSortProvider)?.type,
          searchContent: searchContent.text.trim(),
          getDatatype: GetDataType.fetchdata,
          ref: ref,
          context: context,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          products: products,
          isFetchingData: isFetchingData,
        );
      });

      scrollController.onScrollEndsListener(
        () async {
          await fetchData(
            filterContent: categoryType == CategoryType.normal
                ? ref.read(optionFilterProvider)?.type
                : categoryType.type,
            sortContent: ref.read(optionSortProvider)?.type,
            searchContent: searchContent.text.trim(),
            getDatatype: GetDataType.loadmore,
            ref: ref,
            context: context,
            pageNumber: pageNumber,
            isLastPage: isLastPage,
            isLoadMoreLoading: isLoadMoreLoading,
            products: products,
            isFetchingData: isFetchingData,
          );
        },
      );

      return () {
        scrollController.dispose;
      };
    }, const []);

    return Padding(
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
              if (categoryType == CategoryType.normal)
                InkWell(
                  onTap: () => bottomSheetFilter(
                    context: context,
                    size: size,
                    onCallback: () => fetchData(
                      filterContent: categoryType == CategoryType.normal
                          ? ref.read(optionFilterProvider)?.type
                          : categoryType.type,
                      sortContent: ref.read(optionSortProvider)?.type,
                      getDatatype: GetDataType.fetchdata,
                      ref: ref,
                      context: context,
                      pageNumber: pageNumber,
                      isLastPage: isLastPage,
                      isLoadMoreLoading: isLoadMoreLoading,
                      products: products,
                      isFetchingData: isFetchingData,
                      searchContent: searchContent.text.trim(),
                    ),
                  ),
                  child: FilterSortBox(
                    clickable: true,
                    content: ref.watch(optionFilterProvider) != null
                        ? getTitleProductType(ref.watch(optionFilterProvider)!)
                        : 'Loại',
                  ),
                ),
              if (categoryType == CategoryType.normal)
                SizedBox(width: size.width * 0.03),
              InkWell(
                onTap: () => bottomSheetSort(
                  context: context,
                  size: size,
                  onCallback: () => fetchData(
                    filterContent: categoryType == CategoryType.normal
                        ? ref.read(optionFilterProvider)?.type
                        : categoryType.type,
                    sortContent: ref.read(optionSortProvider)?.type,
                    getDatatype: GetDataType.fetchdata,
                    ref: ref,
                    context: context,
                    pageNumber: pageNumber,
                    isLastPage: isLastPage,
                    isLoadMoreLoading: isLoadMoreLoading,
                    products: products,
                    isFetchingData: isFetchingData,
                    searchContent: searchContent.text.trim(),
                  ),
                ),
                child: FilterSortBox(
                  clickable: true,
                  content: ref.watch(optionSortProvider) != null
                      ? getTitleSortType(ref.watch(optionSortProvider)!)
                      : 'Giá',
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.015),
          ProductSearchBox(
            controller: searchContent,
            onCallBack: (val) {
              fetchData(
                filterContent: categoryType == CategoryType.normal
                    ? ref.read(optionFilterProvider)?.type
                    : categoryType.type,
                sortContent: ref.read(optionSortProvider)?.type,
                searchContent: searchContent.text.trim(),
                getDatatype: GetDataType.fetchdata,
                ref: ref,
                context: context,
                pageNumber: pageNumber,
                isLastPage: isLastPage,
                isLoadMoreLoading: isLoadMoreLoading,
                products: products,
                isFetchingData: isFetchingData,
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
              ? Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (_, index) => const ProductShimmer(amount: 2),
                  ),
                )
              : products.value.isEmpty
                  ? const Align(
                      alignment: Alignment.topCenter,
                      child: EmptyBox(title: 'không có sản phẩm'),
                    )
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
                            onTap: () {
                              unfocus(context);
                              context.router.push(
                                ProductDetailScreenRoute(
                                  productType: products.value[index].type,
                                  productId: products.value[index].productId,
                                ),
                              );
                            },
                            child: ProductItem(
                              product: products.value[index],
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
