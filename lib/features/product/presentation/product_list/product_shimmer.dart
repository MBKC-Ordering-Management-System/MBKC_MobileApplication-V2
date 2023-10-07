import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/asset_constant.dart';

List<Widget> _generateWidget(int amount, Size size) {
  // <<<<< Note this change for the return type
  List<Widget> listings = [];
  int i = 0;
  for (i = 0; i < amount; i++) {
    listings.add(
      SizedBox(
        height: size.height * 0.15,
        width: size.width * 0.9,
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: size.height * 0.11,
                width: size.width * 0.21,
                decoration: BoxDecoration(
                  color: AssetsConstants.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.025),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: size.height * 0.02,
                        width: size.width * 0.03,
                        decoration: BoxDecoration(
                          color: AssetsConstants.whiteColor,
                          borderRadius: BorderRadius.circular(
                            AssetsConstants.defaultBorder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: size.height * 0.02,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          color: AssetsConstants.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.035),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: size.height * 0.02,
                    width: size.width * 0.6,
                    decoration: BoxDecoration(
                      color: AssetsConstants.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: size.width * 0.035),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: size.height * 0.02,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      color: AssetsConstants.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  return listings;
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    super.key,
    required this.amount,
  });
  final int amount;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        ..._generateWidget(amount, size),
      ],
    );
  }
}
