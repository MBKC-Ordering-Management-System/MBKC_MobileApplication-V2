import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;
import '../../domain/models/product_model.dart';
import '../../../../utils/constants/asset_constant.dart';

@RoutePage()
class ProductDetailScreen extends HookConsumerWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // intit
    final size = MediaQuery.sizeOf(context);
    final tabController = useTabController(
      initialLength: 3,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      expandedHeight: size.height * 0.4,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: product.productId.toString() + product.code,
                          child: product.image.isEmpty
                              ? Image.asset(AssetsConstants.defaultAvatar)
                              : FadeInImage(
                                  placeholder: const AssetImage(
                                      AssetsConstants.welcomeImage),
                                  image: NetworkImage(product.image),
                                ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: size.height * 0.06,
                        maxHeight: size.height * 0.06,
                        child: Container(
                          color: Colors.green[200],
                          child: TabBar(
                            controller: tabController,
                            tabs: const [
                              Tab(
                                child: Text(
                                  'TITLE1',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'TITLE2',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'TITLE3',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: AssetsConstants.defaultPadding + 580,
                        ),
                        child: Column(
                          children: [
                            // RoundedPicture(),
                            const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 150.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            const FittedBox(
                              child: Text("Hello World",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 40)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info1:  ',
                                      children: [
                                        TextSpan(
                                          text: "123",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info2:  ',
                                      children: [
                                        TextSpan(
                                          text: "abcd",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info3:  ',
                                      children: [
                                        TextSpan(
                                          text: "xyz",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 600),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 600),
                              child: const Center(
                                child: Text("TITLE2"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 600),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 600),
                              child: const Center(
                                child: Text("TITLE3"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
