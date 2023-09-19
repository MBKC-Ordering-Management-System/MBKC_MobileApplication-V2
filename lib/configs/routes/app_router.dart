// ignore_for_file: unused_field
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../error_screen.dart';
import '../../features/auth/presentation/otp_verification/otp_verification_screen.dart';
import '../../features/auth/presentation/sign_in/sign_in_screen.dart';
import '../../features/home_screen.dart';
import '../../splash_screen.dart';
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
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: OTPVerificationScreenRoute.page),
        // order
        // product
        // profile
        // partner
        // transaction
      ];
}

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));
