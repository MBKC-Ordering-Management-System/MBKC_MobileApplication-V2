import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/asset_constant.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: size.height * 0.2,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: AssetsConstants.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: size.height * 0.2,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: AssetsConstants.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
