import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/category_type_enum.dart';
import '../../domain/models/category_model.dart';
import 'category_detail_controller.dart';
import 'category_detail_extra_tab.dart';
import 'category_detail_information_tab.dart';
import 'category_detail_product_tab.dart';
import 'product_detail/product_detail_shimmer.dart';

@RoutePage()
class CategoryDetailScreen extends HookConsumerWidget {
  const CategoryDetailScreen(this.categoryId, this.categoryType, {super.key});
  final int categoryId;
  final CategoryType categoryType;

  // fetch data
  Future<void> fetchData({
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<CategoryModel?> category,
  }) async {
    final categoryData = await ref
        .read(categoryDetailControllerProvider.notifier)
        .getCategoryDetail(context, categoryId);

    category.value = categoryData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // intit
    final category = useState<CategoryModel?>(null);
    final tabController = useTabController(
      initialLength: categoryType == CategoryType.normal ? 3 : 2,
    );
    final state = ref.watch(categoryDetailControllerProvider);

    // fetch data
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchData(ref: ref, context: context, category: category);
      });

      return () {
        tabController.dispose;
      };
    }, const []);

    return state.isLoading
        ? Container(
            color: AssetsConstants.whiteColor,
            child: const SafeArea(
              child: Scaffold(
                body: ProductDetailShimmer(),
              ),
            ),
          )
        : category.value == null
            ? const Scaffold(
                body: Align(
                  alignment: Alignment.topCenter,
                  child: EmptyBox(title: 'Sai thông tin'),
                ),
              )
            : DefaultTabController(
                length: categoryType == CategoryType.normal ? 3 : 2,
                child: Container(
                  color: AssetsConstants.whiteColor,
                  child: SafeArea(
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: AssetsConstants.mainColor,
                        centerTitle: true,
                        title: const LabelText(
                          content: 'Thông Tin Danh Mục',
                          size: AssetsConstants.defaultFontSize - 8.0,
                          color: AssetsConstants.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                        bottom: ColoredTabBar(
                          backgroundColor: AssetsConstants.whiteColor,
                          tabBar: TabBar(
                            controller: tabController,
                            indicatorColor: AssetsConstants.primaryDark,
                            dividerColor: AssetsConstants.borderColor,
                            tabs: [
                              const Tab(
                                child: LabelText(
                                  content: 'Thông tin',
                                  size: AssetsConstants.defaultFontSize - 15.0,
                                  color: AssetsConstants.primaryDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (categoryType == CategoryType.normal)
                                const Tab(
                                  child: LabelText(
                                    content: 'Danh mục thêm',
                                    size:
                                        AssetsConstants.defaultFontSize - 15.0,
                                    color: AssetsConstants.primaryDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              const Tab(
                                child: LabelText(
                                  content: 'Sản phẩm',
                                  size: AssetsConstants.defaultFontSize - 15.0,
                                  color: AssetsConstants.primaryDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AssetsConstants.defaultPadding - 10.0,
                        ),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            CategoryDetailInformationTab(
                              category: category.value!,
                            ),
                            if (categoryType == CategoryType.normal)
                              CategoryDetailExtraTab(
                                categoriesExtra:
                                    category.value!.extraCategories!,
                              ),
                            CategoryDetailProductTab(
                              categoryId,
                              category.value!.type!,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }
}
