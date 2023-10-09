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
import '../../features/partner/domain/models/partner_model.dart';
import '../../features/partner/presentation/partner_detail/partner_detail_screen.dart';
import '../../features/partner/presentation/partner_list/partner_screen.dart';
import '../../features/partner/presentation/partner_modify/partner_modify_screen.dart';
import '../../features/product/presentation/product_detail/product_detail_screen.dart';
import '../../features/product/presentation/product_list/product_screen.dart';
import '../../features/profile/domain/models/profile_model.dart';
import '../../features/profile/presentation/profile/profile_screen.dart';
import '../../features/order/domain/models/order_model.dart';
import '../../features/profile/presentation/profile_detail/profile_detail_screen.dart';
import '../../features/wallet/domain/models/transaction_model.dart';
import '../../features/wallet/presentation/banking_account_list/banking_account_screen.dart';
import '../../features/wallet/presentation/transaction_detail.dart/transaction_detail_screen.dart';
import '../../features/wallet/presentation/transaction_list/transaction_screen.dart';
import '../../features/wallet/presentation/wallet_balance/wallet_screen.dart';
import '../../models/token_model.dart';
import '../../models/user_model.dart';
import '../../tabview_screen.dart';
import '../../utils/enums/modify_type.dart';
import '../../utils/enums/verification_otp_type.dart';

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

        // common
        AutoRoute(page: ErrorScreenRoute.page),

        // auth
        AutoRoute(
          page: SignInScreenRoute.page,
          initial: true,
        ),
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

        // profile
        AutoRoute(page: ProfileDetailScreenRoute.page),

        // order
        AutoRoute(page: OrderDetailScreenRoute.page),

        // partner
        AutoRoute(page: PartnerScreenRoute.page),
        AutoRoute(page: PartnerDetailScreenRoute.page),
        AutoRoute(page: PartnerModifyScreenRoute.page),

        // wallet
        AutoRoute(page: WalletScreenRoute.page),
        AutoRoute(page: BankingAccountScreenRoute.page),
        AutoRoute(page: TransactionScreenRoute.page),
        AutoRoute(page: TransactionDetailScreenRoute.page),

        // product
        AutoRoute(page: ProductDetailScreenRoute.page),
      ];
}

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));
