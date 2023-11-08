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
    CategoryDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryDetailScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoryDetailScreen(
          args.categoryId,
          key: args.key,
        ),
      );
    },
    CategoryScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoryScreen(),
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
          token: args.token,
          user: args.user,
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
          orderId: args.orderId,
        ),
      );
    },
    OrderScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderScreen(),
      );
    },
    ProductDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductDetailScreen(
          args.productId,
          key: args.key,
        ),
      );
    },
    ProfileDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileDetailScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileDetailScreen(
          key: args.key,
          profile: args.profile,
        ),
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
    TransactionDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionDetailScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionDetailScreen(
          key: args.key,
          transaction: args.transaction,
        ),
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
/// [CategoryDetailScreen]
class CategoryDetailScreenRoute
    extends PageRouteInfo<CategoryDetailScreenRouteArgs> {
  CategoryDetailScreenRoute({
    required int categoryId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryDetailScreenRoute.name,
          args: CategoryDetailScreenRouteArgs(
            categoryId: categoryId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryDetailScreenRoute';

  static const PageInfo<CategoryDetailScreenRouteArgs> page =
      PageInfo<CategoryDetailScreenRouteArgs>(name);
}

class CategoryDetailScreenRouteArgs {
  const CategoryDetailScreenRouteArgs({
    required this.categoryId,
    this.key,
  });

  final int categoryId;

  final Key? key;

  @override
  String toString() {
    return 'CategoryDetailScreenRouteArgs{categoryId: $categoryId, key: $key}';
  }
}

/// generated route for
/// [CategoryScreen]
class CategoryScreenRoute extends PageRouteInfo<void> {
  const CategoryScreenRoute({List<PageRouteInfo>? children})
      : super(
          CategoryScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryScreenRoute';

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
    TokenModel? token,
    UserModel? user,
    List<PageRouteInfo>? children,
  }) : super(
          ChangePasswordScreenRoute.name,
          args: ChangePasswordScreenRouteArgs(
            key: key,
            email: email,
            verifyType: verifyType,
            token: token,
            user: user,
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
    this.token,
    this.user,
  });

  final Key? key;

  final String email;

  final VerificationOTPType verifyType;

  final TokenModel? token;

  final UserModel? user;

  @override
  String toString() {
    return 'ChangePasswordScreenRouteArgs{key: $key, email: $email, verifyType: $verifyType, token: $token, user: $user}';
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
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          OrderDetailScreenRoute.name,
          args: OrderDetailScreenRouteArgs(
            key: key,
            orderId: orderId,
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
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'OrderDetailScreenRouteArgs{key: $key, orderId: $orderId}';
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
/// [ProductDetailScreen]
class ProductDetailScreenRoute
    extends PageRouteInfo<ProductDetailScreenRouteArgs> {
  ProductDetailScreenRoute({
    required int productId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProductDetailScreenRoute.name,
          args: ProductDetailScreenRouteArgs(
            productId: productId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailScreenRoute';

  static const PageInfo<ProductDetailScreenRouteArgs> page =
      PageInfo<ProductDetailScreenRouteArgs>(name);
}

class ProductDetailScreenRouteArgs {
  const ProductDetailScreenRouteArgs({
    required this.productId,
    this.key,
  });

  final int productId;

  final Key? key;

  @override
  String toString() {
    return 'ProductDetailScreenRouteArgs{productId: $productId, key: $key}';
  }
}

/// generated route for
/// [ProfileDetailScreen]
class ProfileDetailScreenRoute
    extends PageRouteInfo<ProfileDetailScreenRouteArgs> {
  ProfileDetailScreenRoute({
    Key? key,
    required ProfileModel profile,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileDetailScreenRoute.name,
          args: ProfileDetailScreenRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileDetailScreenRoute';

  static const PageInfo<ProfileDetailScreenRouteArgs> page =
      PageInfo<ProfileDetailScreenRouteArgs>(name);
}

class ProfileDetailScreenRouteArgs {
  const ProfileDetailScreenRouteArgs({
    this.key,
    required this.profile,
  });

  final Key? key;

  final ProfileModel profile;

  @override
  String toString() {
    return 'ProfileDetailScreenRouteArgs{key: $key, profile: $profile}';
  }
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
/// [TransactionDetailScreen]
class TransactionDetailScreenRoute
    extends PageRouteInfo<TransactionDetailScreenRouteArgs> {
  TransactionDetailScreenRoute({
    Key? key,
    required TransactionModel transaction,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionDetailScreenRoute.name,
          args: TransactionDetailScreenRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionDetailScreenRoute';

  static const PageInfo<TransactionDetailScreenRouteArgs> page =
      PageInfo<TransactionDetailScreenRouteArgs>(name);
}

class TransactionDetailScreenRouteArgs {
  const TransactionDetailScreenRouteArgs({
    this.key,
    required this.transaction,
  });

  final Key? key;

  final TransactionModel transaction;

  @override
  String toString() {
    return 'TransactionDetailScreenRouteArgs{key: $key, transaction: $transaction}';
  }
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
