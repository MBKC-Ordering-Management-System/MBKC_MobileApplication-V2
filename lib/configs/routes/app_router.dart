import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/change_password/change_password_screen.dart';
import '../../features/auth/presentation/enter_email/enter_email_screen.dart';
import '../../features/auth/presentation/otp_verification/otp_verification_screen.dart';
import '../../features/auth/presentation/sign_in/sign_in_screen.dart';
import '../../features/category/presentation/category_detail/category_detail_screen.dart';
import '../../features/category/presentation/category_detail/product_detail/product_detail_screen.dart';
import '../../features/category/presentation/category_list/category_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/money_exchange/domain/models/money_exchange_model.dart';
import '../../features/money_exchange/presentation/money_exchange_detail/money_exchange_detail_screen.dart';
import '../../features/money_exchange/presentation/money_exchange_list/money_exchange_screen.dart';
import '../../features/order/presentation/order_detail/order_detail_screen.dart';
import '../../features/order/presentation/order_list/order_screen.dart';
import '../../features/profile/domain/models/profile_model.dart';
import '../../features/profile/presentation/profile/profile_screen.dart';
import '../../features/profile/presentation/profile_detail/profile_detail_screen.dart';
import '../../models/token_model.dart';
import '../../models/user_model.dart';
import '../../tabview_screen.dart';
import '../../utils/enums/enums_export.dart';
import 'guard/auth_guard.dart';

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
          page: SignInScreenRoute.page,
          // initial: true,
        ),
        AutoRoute(page: EnterEmailScreenRoute.page),
        AutoRoute(page: OTPVerificationScreenRoute.page),
        AutoRoute(page: ChangePasswordScreenRoute.page),
        AutoRoute(
          page: TabViewScreenRoute.page,
          initial: true,
          guards: [AuthGuard(ref: _ref)],
          children: [
            AutoRoute(page: HomeScreenRoute.page),
            AutoRoute(page: OrderScreenRoute.page),
            AutoRoute(page: CategoryScreenRoute.page),
            AutoRoute(page: ProfileScreenRoute.page),
          ],
        ),

        // profile
        AutoRoute(page: ProfileDetailScreenRoute.page),

        // order
        AutoRoute(page: OrderDetailScreenRoute.page),

        // wallet
        AutoRoute(page: MoneyExchangeScreenRoute.page),
        AutoRoute(page: MoneyExchangeDetailScreenRoute.page),

        // category
        AutoRoute(page: CategoryDetailScreenRoute.page),

        // product
        AutoRoute(page: ProductDetailScreenRoute.page),
      ];
}

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));
