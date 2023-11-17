// ignore_for_file: unused_local_variable
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../domain/models/category_model.dart';
import '../category_detail/product_list/product_shimmer.dart';
import 'category_bottom_sheet_filter.dart';
import 'category_controller.dart';
import 'category_item.dart';
import 'category_search_box.dart';

@RoutePage()
class CategoryScreen extends HookConsumerWidget {
  const CategoryScreen({super.key});

  // fetch data
  Future<void> fetchData({
    required GetDataType getDatatype,
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<int> pageNumber,
    required ValueNotifier<bool> isLastPage,
    required ValueNotifier<bool> isLoadMoreLoading,
    required ValueNotifier<List<CategoryModel>> categories,
    required ValueNotifier<bool> isFetchingData,
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
    final categoriesData =
        await ref.read(categoryControllerProvider.notifier).getCategories(
              PagingModel(
                pageNumber: pageNumber.value,
                searchContent: searchContent,
                filterContent: filterContent,
              ),
              context,
            );

    isLastPage.value = categoriesData.length < 10;
    if (getDatatype == GetDataType.fetchdata) {
      isLoadMoreLoading.value = true;
      categories.value = categoriesData;
      isFetchingData.value = false;
      return;
    }

    isFetchingData.value = false;
    categories.value = categories.value + categoriesData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final categories = useState<List<CategoryModel>>([]);
    final scrollController = useScrollController();
    final state = ref.watch(categoryControllerProvider);
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
          filterContent: ref.read(categoryFilterProvider).type,
          searchContent: searchContent.text.trim(),
          getDatatype: GetDataType.fetchdata,
          ref: ref,
          context: context,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          categories: categories,
          isFetchingData: isFetchingData,
        );
      });

      scrollController.onScrollEndsListener(
        () async {
          await fetchData(
            filterContent: ref.read(categoryFilterProvider).type,
            searchContent: searchContent.text.trim(),
            getDatatype: GetDataType.loadmore,
            ref: ref,
            context: context,
            pageNumber: pageNumber,
            isLastPage: isLastPage,
            isLoadMoreLoading: isLoadMoreLoading,
            categories: categories,
            isFetchingData: isFetchingData,
          );
        },
      );

      return () {
        scrollController.dispose;
      };
    }, const []);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Danh Mục Sản Phẩm',
        iconFirst: Icons.refresh_rounded,
        onCallBackFirst: () => fetchData(
          filterContent: ref.read(categoryFilterProvider).type,
          searchContent: searchContent.text.trim(),
          getDatatype: GetDataType.fetchdata,
          ref: ref,
          context: context,
          pageNumber: pageNumber,
          isLastPage: isLastPage,
          isLoadMoreLoading: isLoadMoreLoading,
          categories: categories,
          isFetchingData: isFetchingData,
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
            InkWell(
              onTap: () => categoryBottomSheetFilter(
                context: context,
                size: size,
                onCallback: () => fetchData(
                  filterContent: ref.read(categoryFilterProvider).type,
                  getDatatype: GetDataType.fetchdata,
                  ref: ref,
                  context: context,
                  pageNumber: pageNumber,
                  isLastPage: isLastPage,
                  isLoadMoreLoading: isLoadMoreLoading,
                  categories: categories,
                  isFetchingData: isFetchingData,
                  searchContent: searchContent.text.trim(),
                ),
              ),
              child: FilterSortBox(
                clickable: true,
                content:
                    ref.watch(categoryFilterProvider) == CategoryType.normal
                        ? 'Thường'
                        : 'Thêm',
              ),
            ),
            SizedBox(height: size.height * 0.015),
            CategorySearchBox(
              controller: searchContent,
              onCallBack: (val) {
                fetchData(
                  filterContent: ref.read(categoryFilterProvider).type,
                  searchContent: searchContent.text.trim(),
                  getDatatype: GetDataType.fetchdata,
                  ref: ref,
                  context: context,
                  pageNumber: pageNumber,
                  isLastPage: isLastPage,
                  isLoadMoreLoading: isLoadMoreLoading,
                  categories: categories,
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
                      itemBuilder: (_, index) =>
                          const ProductShimmer(amount: 2),
                    ),
                  )
                : categories.value.isEmpty
                    ? const Align(
                        alignment: Alignment.topCenter,
                        child: EmptyBox(title: 'Không có danh mục'),
                      )
                    : Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: categories.value.length + 1,
                          itemBuilder: (_, index) {
                            if (index == categories.value.length) {
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
                                  CategoryDetailScreenRoute(
                                    categoryType: categories.value[index].type!,
                                    categoryId:
                                        categories.value[index].categoryId!,
                                  ),
                                );
                              },
                              child: CategoryItem(
                                category: categories.value[index],
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
