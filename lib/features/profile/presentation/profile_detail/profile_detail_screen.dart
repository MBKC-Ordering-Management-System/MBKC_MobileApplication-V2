import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/profile_model.dart';

@RoutePage()
class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    // intit
    final size = MediaQuery.sizeOf(context);

    return Container(
      color: AssetsConstants.whiteColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () => context.router.pop(),
                  icon: Stack(
                    children: [
                      Container(
                        height: size.height * 0.045,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: AssetsConstants.black_20.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(
                            AssetsConstants.defaultBorder + 20,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: AssetsConstants.whiteColor,
                            size: AssetsConstants.defaultFontSize - 5.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                expandedHeight: size.height * 0.26,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: profile.storeId,
                    child: profile.logo.isEmpty
                        ? Image.asset(
                            AssetsConstants.defaultAvatar,
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            placeholder:
                                const AssetImage(AssetsConstants.welcomeImage),
                            image: NetworkImage(profile.logo),
                          ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AssetsConstants.defaultPadding - 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.01),
                          const LabelText(
                            content: 'Cửa hàng',
                            size: AssetsConstants.defaultFontSize - 12.0,
                            color: AssetsConstants.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: size.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: LabelText(
                                  content: profile.name,
                                  size: AssetsConstants.defaultFontSize - 12.0,
                                  fontWeight: FontWeight.bold,
                                  maxLine: 3,
                                ),
                              ),
                              SizedBox(width: size.width * 0.01),
                              CustomLabelStatus(
                                width: size.width * 0.3,
                                height: size.height * 0.04,
                                content: profile.status.toStatusTypeEnum().type,
                                size: AssetsConstants.defaultFontSize - 18.0,
                                backgroundColor: getBackgrounStatusColor(
                                    profile.status.toStatusTypeEnum()),
                                contentColor: getContentStatusColor(
                                    profile.status.toStatusTypeEnum()),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          ContentBox(
                            label: 'Địa chỉ:',
                            content: profile.kitchenCenter!.address,
                          ),
                          SizedBox(height: size.height * 0.01),
                          ContentBox(
                            label: 'Email:',
                            content: profile.storeManagerEmail,
                          ),
                          SizedBox(height: size.height * 0.01),
                          const LinearHorizontal(),
                          SizedBox(height: size.height * 0.01),
                          const LabelText(
                            content: 'Nhãn hàng',
                            size: AssetsConstants.defaultFontSize - 12.0,
                            color: AssetsConstants.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: size.height * 0.01),
                          LabelText(
                            content: profile.brand.name,
                            size: AssetsConstants.defaultFontSize - 12.0,
                            fontWeight: FontWeight.bold,
                            maxLine: 5,
                          ),
                          SizedBox(height: size.height * 0.01),
                          ContentBox(
                            label: 'Email:',
                            content: profile.brand.brandManagerEmail,
                          ),
                          SizedBox(height: size.height * 0.01),
                          const LinearHorizontal(),
                          SizedBox(height: size.height * 0.01),
                          const LabelText(
                            content: 'Bếp trung tâm',
                            size: AssetsConstants.defaultFontSize - 12.0,
                            color: AssetsConstants.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: size.height * 0.01),
                          LabelText(
                            content: profile.kitchenCenter!.name,
                            size: AssetsConstants.defaultFontSize - 12.0,
                            fontWeight: FontWeight.bold,
                            maxLine: 5,
                          ),
                          SizedBox(height: size.height * 0.01),
                          ContentBox(
                            label: 'Email:',
                            content: profile
                                .kitchenCenter!.kitchenCenterManagerEmail,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
