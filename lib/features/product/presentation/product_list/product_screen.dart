import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../models/product_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/widgets/custom_bottom_sheet.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
//import '../../../../utils/enums/searching_type_enum.dart';
import '../../../../utils/extensions/extensions_export.dart';
import 'filter_sort_box.dart';
import 'product_controller.dart';
import 'product_item.dart';
import 'search_box.dart';

@RoutePage()
class ProductScreen extends HookConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final products = useState<List<ProductModel>>([]);
    final scrollController = useScrollController();
    final state = ref.watch(productControllerProvider);

    // searching
    final searchContent = useTextEditingController();
    //final sortContent = useState<SearchingType?>(null);
    //final filterContent = useTextEditingController();

    // paging
    final pageNumber = useState(0);
    final isLastPage = useState(false);
    final isShowNoMoreData = useState(false);
    final isLoadMoreLoading = useState(false);

    // fetch data
    Future<void> fetchData() async {
      pageNumber.value = 0;
      isLastPage.value = false;
      isShowNoMoreData.value = false;
      isLoadMoreLoading.value = false;
      pageNumber.value = pageNumber.value + 1;

      final productsData = await ref
          .read(productControllerProvider.notifier)
          .getProducts(PagingModel(pageNumber: pageNumber.value), context);

      isLastPage.value = productsData.length < 10;
      isLoadMoreLoading.value = true;

      products.value = productsData;
    }

    // scroll to load
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
      final productsData = await ref
          .read(productControllerProvider.notifier)
          .getProducts(PagingModel(pageNumber: pageNumber.value), context);

      isLastPage.value = productsData.length < 10;
      products.value = products.value + productsData;
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

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: const CustomeAppBar(
        title: 'Sản Phẩm',
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
                InkWell(
                  onTap: () {
                    showCustomBottomSheet(context: context);
                  },
                  child: const FilterSortBox(content: 'Loại'),
                ),
                SizedBox(width: size.width * 0.03),
                const FilterSortBox(content: 'Giá'),
              ],
            ),
            SizedBox(height: size.height * 0.015),
            SearchBox(controller: searchContent),
            Container(
              height: size.height * 0.015,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AssetsConstants.borderColor),
                ),
              ),
            ),
            state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: products.value.length,
                      itemBuilder: (_, index) => ProductItem(
                        product: products.value[index],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
