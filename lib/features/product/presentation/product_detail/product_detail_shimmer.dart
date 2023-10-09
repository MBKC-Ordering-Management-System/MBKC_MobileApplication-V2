import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/constants/asset_constant.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: size.height * 0.36,
            width: size.width * 1,
            decoration: BoxDecoration(
              color: AssetsConstants.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: size.height * 0.03,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: AssetsConstants.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: size.height * 0.03,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: AssetsConstants.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AssetsConstants.defaultPadding - 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: size.height * 0.03,
                  width: size.width * 0.3,
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
                  height: size.height * 0.03,
                  width: size.width * 0.7,
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
                  height: size.height * 0.03,
                  width: size.width * 0.3,
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
                  height: size.height * 0.03,
                  width: size.width * 0.7,
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
                  height: size.height * 0.03,
                  width: size.width * 0.3,
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
                  height: size.height * 0.03,
                  width: size.width * 0.7,
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
                  height: size.height * 0.03,
                  width: size.width * 0.3,
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
                  height: size.height * 0.03,
                  width: size.width * 0.7,
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
                  height: size.height * 0.03,
                  width: size.width * 0.3,
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
                  height: size.height * 0.03,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: AssetsConstants.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
