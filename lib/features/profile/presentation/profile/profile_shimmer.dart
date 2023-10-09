import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/constants/asset_constant.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.all(
        AssetsConstants.defaultPadding - 10.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    color: AssetsConstants.whiteColor,
                    borderRadius: BorderRadius.circular(
                      AssetsConstants.defaultBorder + 20,
                    ),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: AssetsConstants.whiteColor,
                    borderRadius: BorderRadius.circular(
                      AssetsConstants.defaultBorder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
