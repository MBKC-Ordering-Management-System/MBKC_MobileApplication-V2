import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../domain/models/profile_model.dart';

class ProfileBox extends StatelessWidget {
  const ProfileBox({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: () {
        context.router.push(ProfileDetailScreenRoute(profile: profile));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AssetsConstants.defaultPadding - 10.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AssetsConstants.borderColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AssetsConstants.defaultPadding - 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height * 0.115,
                width: size.width * 0.21,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AssetsConstants.defaultBorder + 50.0,
                  ),
                  child: Hero(
                    tag: profile.storeId,
                    child: profile.logo.isEmpty
                        ? Image.asset(AssetsConstants.defaultAvatar)
                        : FadeInImage(
                            placeholder:
                                const AssetImage(AssetsConstants.welcomeImage),
                            image: NetworkImage(profile.logo),
                          ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.025),
              Expanded(
                child: LabelText(
                  content: profile.name,
                  size: AssetsConstants.defaultFontSize - 10.0,
                  fontWeight: FontWeight.bold,
                  maxLine: 1,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AssetsConstants.subtitleColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
