import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../domain/models/profile_model.dart';
import '../../../../utils/commons/widgets/field_box.dart';

@RoutePage()
class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    // intit
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: Stack(
                children: [
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      color: AssetsConstants.black_20.withOpacity(0.4),
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
                    children: [
                      SizedBox(height: size.height * 0.01),
                      FieldBox(title: 'Tên bếp', content: profile.name),
                      SizedBox(height: size.height * 0.01),
                      FieldBox(
                        title: 'Trạng thái',
                        content: getTitleStatus(profile.status),
                      ),
                      SizedBox(height: size.height * 0.01),
                      FieldBox(
                        title: 'Địa chỉ',
                        content: profile.kitchenCenter!.address,
                      ),
                      SizedBox(height: size.height * 0.01),
                      FieldBox(
                        title: 'Email chủ bếp',
                        content: profile.storeManagerEmail,
                      ),
                      SizedBox(height: size.height * 0.01),
                      FieldBox(
                        title: 'Nhãn hàng',
                        content: profile.brand.name,
                      ),
                      SizedBox(height: size.height * 0.01),
                      FieldBox(
                        title: 'Email chủ nhãn hàng',
                        content: profile.brand.brandManagerEmail,
                      ),
                      SizedBox(height: size.height * 0.01),
                      FieldBox(
                        title: 'Bếp trung tâm',
                        content: profile.kitchenCenter!.name,
                      ),
                      SizedBox(height: size.height * 0.01),
                      FieldBox(
                        title: 'Email chủ bếp trung tâm',
                        content: profile.kitchenCenter!.name,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
