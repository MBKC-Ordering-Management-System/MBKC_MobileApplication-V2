// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BankingAccountScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BankingAccountScreen(),
      );
    },
    ChangePasswordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangePasswordScreen(
          key: args.key,
          email: args.email,
          verifyType: args.verifyType,
        ),
      );
    },
    EnterEmailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<EnterEmailScreenRouteArgs>(
          orElse: () => const EnterEmailScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EnterEmailScreen(key: args.key),
      );
    },
    ErrorScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ErrorScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    OTPVerificationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OTPVerificationScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OTPVerificationScreen(
          key: args.key,
          email: args.email,
          verifyType: args.verifyType,
        ),
      );
    },
    OrderDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderDetailScreen(
          key: args.key,
          order: args.order,
        ),
      );
    },
    OrderScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderScreen(),
      );
    },
    PartnerDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PartnerDetailScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PartnerDetailScreen(
          key: args.key,
          partner: args.partner,
        ),
      );
    },
    PartnerModifyScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PartnerModifyScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PartnerModifyScreen(
          key: args.key,
          partner: args.partner,
          type: args.type,
        ),
      );
    },
    PartnerScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PartnerScreen(),
      );
    },
    ProductScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProductScreen(),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    SignInScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SignInScreenRouteArgs>(
          orElse: () => const SignInScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignInScreen(key: args.key),
      );
    },
    TabViewScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TabViewScreen(),
      );
    },
    TransactionScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TransactionScreen(),
      );
    },
    WalletScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WalletScreen(),
      );
    },
  };
}

/// generated route for
/// [BankingAccountScreen]
class BankingAccountScreenRoute extends PageRouteInfo<void> {
  const BankingAccountScreenRoute({List<PageRouteInfo>? children})
      : super(
          BankingAccountScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'BankingAccountScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangePasswordScreen]
class ChangePasswordScreenRoute
    extends PageRouteInfo<ChangePasswordScreenRouteArgs> {
  ChangePasswordScreenRoute({
    Key? key,
    required String email,
    required VerificationOTPType verifyType,
    List<PageRouteInfo>? children,
  }) : super(
          ChangePasswordScreenRoute.name,
          args: ChangePasswordScreenRouteArgs(
            key: key,
            email: email,
            verifyType: verifyType,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordScreenRoute';

  static const PageInfo<ChangePasswordScreenRouteArgs> page =
      PageInfo<ChangePasswordScreenRouteArgs>(name);
}

class ChangePasswordScreenRouteArgs {
  const ChangePasswordScreenRouteArgs({
    this.key,
    required this.email,
    required this.verifyType,
  });

  final Key? key;

  final String email;

  final VerificationOTPType verifyType;

  @override
  String toString() {
    return 'ChangePasswordScreenRouteArgs{key: $key, email: $email, verifyType: $verifyType}';
  }
}

/// generated route for
/// [EnterEmailScreen]
class EnterEmailScreenRoute extends PageRouteInfo<EnterEmailScreenRouteArgs> {
  EnterEmailScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EnterEmailScreenRoute.name,
          args: EnterEmailScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'EnterEmailScreenRoute';

  static const PageInfo<EnterEmailScreenRouteArgs> page =
      PageInfo<EnterEmailScreenRouteArgs>(name);
}

class EnterEmailScreenRouteArgs {
  const EnterEmailScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'EnterEmailScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ErrorScreen]
class ErrorScreenRoute extends PageRouteInfo<void> {
  const ErrorScreenRoute({List<PageRouteInfo>? children})
      : super(
          ErrorScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute({List<PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OTPVerificationScreen]
class OTPVerificationScreenRoute
    extends PageRouteInfo<OTPVerificationScreenRouteArgs> {
  OTPVerificationScreenRoute({
    Key? key,
    required String email,
    required VerificationOTPType verifyType,
    List<PageRouteInfo>? children,
  }) : super(
          OTPVerificationScreenRoute.name,
          args: OTPVerificationScreenRouteArgs(
            key: key,
            email: email,
            verifyType: verifyType,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPVerificationScreenRoute';

  static const PageInfo<OTPVerificationScreenRouteArgs> page =
      PageInfo<OTPVerificationScreenRouteArgs>(name);
}

class OTPVerificationScreenRouteArgs {
  const OTPVerificationScreenRouteArgs({
    this.key,
    required this.email,
    required this.verifyType,
  });

  final Key? key;

  final String email;

  final VerificationOTPType verifyType;

  @override
  String toString() {
    return 'OTPVerificationScreenRouteArgs{key: $key, email: $email, verifyType: $verifyType}';
  }
}

/// generated route for
/// [OrderDetailScreen]
class OrderDetailScreenRoute extends PageRouteInfo<OrderDetailScreenRouteArgs> {
  OrderDetailScreenRoute({
    Key? key,
    required OrderModel order,
    List<PageRouteInfo>? children,
  }) : super(
          OrderDetailScreenRoute.name,
          args: OrderDetailScreenRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailScreenRoute';

  static const PageInfo<OrderDetailScreenRouteArgs> page =
      PageInfo<OrderDetailScreenRouteArgs>(name);
}

class OrderDetailScreenRouteArgs {
  const OrderDetailScreenRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final OrderModel order;

  @override
  String toString() {
    return 'OrderDetailScreenRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [OrderScreen]
class OrderScreenRoute extends PageRouteInfo<void> {
  const OrderScreenRoute({List<PageRouteInfo>? children})
      : super(
          OrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PartnerDetailScreen]
class PartnerDetailScreenRoute
    extends PageRouteInfo<PartnerDetailScreenRouteArgs> {
  PartnerDetailScreenRoute({
    Key? key,
    required PartnerModel partner,
    List<PageRouteInfo>? children,
  }) : super(
          PartnerDetailScreenRoute.name,
          args: PartnerDetailScreenRouteArgs(
            key: key,
            partner: partner,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerDetailScreenRoute';

  static const PageInfo<PartnerDetailScreenRouteArgs> page =
      PageInfo<PartnerDetailScreenRouteArgs>(name);
}

class PartnerDetailScreenRouteArgs {
  const PartnerDetailScreenRouteArgs({
    this.key,
    required this.partner,
  });

  final Key? key;

  final PartnerModel partner;

  @override
  String toString() {
    return 'PartnerDetailScreenRouteArgs{key: $key, partner: $partner}';
  }
}

/// generated route for
/// [PartnerModifyScreen]
class PartnerModifyScreenRoute
    extends PageRouteInfo<PartnerModifyScreenRouteArgs> {
  PartnerModifyScreenRoute({
    Key? key,
    PartnerModel? partner,
    required ModifyType type,
    List<PageRouteInfo>? children,
  }) : super(
          PartnerModifyScreenRoute.name,
          args: PartnerModifyScreenRouteArgs(
            key: key,
            partner: partner,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerModifyScreenRoute';

  static const PageInfo<PartnerModifyScreenRouteArgs> page =
      PageInfo<PartnerModifyScreenRouteArgs>(name);
}

class PartnerModifyScreenRouteArgs {
  const PartnerModifyScreenRouteArgs({
    this.key,
    this.partner,
    required this.type,
  });

  final Key? key;

  final PartnerModel? partner;

  final ModifyType type;

  @override
  String toString() {
    return 'PartnerModifyScreenRouteArgs{key: $key, partner: $partner, type: $type}';
  }
}

/// generated route for
/// [PartnerScreen]
class PartnerScreenRoute extends PageRouteInfo<void> {
  const PartnerScreenRoute({List<PageRouteInfo>? children})
      : super(
          PartnerScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'PartnerScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductScreen]
class ProductScreenRoute extends PageRouteInfo<void> {
  const ProductScreenRoute({List<PageRouteInfo>? children})
      : super(
          ProductScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileScreenRoute extends PageRouteInfo<void> {
  const ProfileScreenRoute({List<PageRouteInfo>? children})
      : super(
          ProfileScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInScreen]
class SignInScreenRoute extends PageRouteInfo<SignInScreenRouteArgs> {
  SignInScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignInScreenRoute.name,
          args: SignInScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInScreenRoute';

  static const PageInfo<SignInScreenRouteArgs> page =
      PageInfo<SignInScreenRouteArgs>(name);
}

class SignInScreenRouteArgs {
  const SignInScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignInScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [TabViewScreen]
class TabViewScreenRoute extends PageRouteInfo<void> {
  const TabViewScreenRoute({List<PageRouteInfo>? children})
      : super(
          TabViewScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabViewScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransactionScreen]
class TransactionScreenRoute extends PageRouteInfo<void> {
  const TransactionScreenRoute({List<PageRouteInfo>? children})
      : super(
          TransactionScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WalletScreen]
class WalletScreenRoute extends PageRouteInfo<void> {
  const WalletScreenRoute({List<PageRouteInfo>? children})
      : super(
          WalletScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
