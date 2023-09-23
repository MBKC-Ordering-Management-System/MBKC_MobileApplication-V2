// ignore_for_file: unused_field
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../error_screen.dart';
import '../../features/auth/presentation/change_password/change_password_screen.dart';
import '../../features/auth/presentation/enter_email/enter_email_screen.dart';
import '../../features/auth/presentation/otp_verification/otp_verification_screen.dart';
import '../../features/auth/presentation/sign_in/sign_in_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/order/presentation/order_detail/order_detail_screen.dart';
import '../../features/order/presentation/order_list/order_screen.dart';
import '../../features/product/presentation/product_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../models/order_model.dart';
import '../../splash_screen.dart';
import '../../tabview_screen.dart';
import '../../utils/enums/verification_type_enum.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends _$AppRouter {
  final Ref _ref;
  AppRouter({
    required Ref ref,
  }) : _ref = ref;

  @override
  List<AutoRoute> get routes => [
        // routes go here

        // auth
        AutoRoute(
          page: SplashScreenRoute.page,
          initial: true,
        ),
        AutoRoute(page: SignInScreenRoute.page),
        AutoRoute(page: EnterEmailScreenRoute.page),
        AutoRoute(page: OTPVerificationScreenRoute.page),
        AutoRoute(page: ChangePasswordScreenRoute.page),
        AutoRoute(
          page: TabViewScreenRoute.page,
          // initial: true,
          children: [
            AutoRoute(page: HomeScreenRoute.page),
            AutoRoute(page: OrderScreenRoute.page),
            AutoRoute(page: ProductScreenRoute.page),
            AutoRoute(page: ProfileScreenRoute.page),
          ],
        ),

        // order
        AutoRoute(page: OrderDetailScreenRoute.page),
        // AutoRoute(page: OrderScreenRoute.page),
        // product
        // AutoRoute(page: ProductScreenRoute.page),
        // profile
        // AutoRoute(page: ProfileScreenRoute.page),
        // partner

        // transaction
      ];
}

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));
