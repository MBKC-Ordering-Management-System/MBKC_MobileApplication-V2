import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../product/presentation/product_detail/product_detail_shimmer.dart';
import '../../domain/models/category_model.dart';
import 'category_detail_controller.dart';
import 'category_detail_information_tab.dart';

@RoutePage()
class CategoryDetailScreen extends HookConsumerWidget {
  const CategoryDetailScreen(this.categoryId, {super.key});
  final int categoryId;

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
    final size = MediaQuery.sizeOf(context);
    final category = useState<CategoryModel?>(null);
    final tabController = useTabController(
      initialLength: 3,
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

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: state.isLoading
            ? const ProductDetailShimmer()
            : category.value == null
                ? const Align(
                    alignment: Alignment.topCenter,
                    child: EmptyBox(title: 'Sai thông tin'),
                  )
                : Stack(
                    children: [
                      DefaultTabController(
                        length: 3,
                        child: NestedScrollView(
                          headerSliverBuilder: (context, value) {
                            return [
                              SliverAppBar(
                                leading: IconButton(
                                  onPressed: () => context.router.pop(),
                                  icon: Stack(
                                    children: [
                                      Container(
                                        height: size.height * 0.1,
                                        width: size.width * 0.2,
                                        decoration: BoxDecoration(
                                          color: AssetsConstants.black_20
                                              .withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(
                                            AssetsConstants.defaultBorder + 20,
                                          ),
                                        ),
                                      ),
                                      const Center(
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: AssetsConstants.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                expandedHeight: size.height * 0.36,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: category.value!.imageUrl == null
                                      ? Image.asset(
                                          AssetsConstants.defaultAvatar)
                                      : FadeInImage(
                                          fit: BoxFit.cover,
                                          placeholder: const AssetImage(
                                            AssetsConstants.welcomeImage,
                                          ),
                                          image: NetworkImage(
                                            category.value!.imageUrl!,
                                          ),
                                        ),
                                ),
                              ),
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: SliverAppBarDelegate(
                                  minHeight: size.height * 0.06,
                                  maxHeight: size.height * 0.06,
                                  child: Container(
                                    color: AssetsConstants.whiteColor,
                                    child: TabBar(
                                      indicatorColor: AssetsConstants.mainColor,
                                      dividerColor: AssetsConstants.borderColor,
                                      controller: tabController,
                                      tabs: const [
                                        Tab(
                                          child: LabelText(
                                            content: 'Thông tin',
                                            size: AssetsConstants
                                                    .defaultFontSize -
                                                15.0,
                                            color: AssetsConstants.mainColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Tab(
                                          child: LabelText(
                                            content: 'Danh mục thêm',
                                            size: AssetsConstants
                                                    .defaultFontSize -
                                                15.0,
                                            color: AssetsConstants.mainColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Tab(
                                          child: LabelText(
                                            content: 'Sản phẩm',
                                            size: AssetsConstants
                                                    .defaultFontSize -
                                                15.0,
                                            color: AssetsConstants.mainColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ];
                          },
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
                                Container(),
                                Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
