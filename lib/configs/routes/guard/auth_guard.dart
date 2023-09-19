// ignore_for_file: unused_field
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref _ref;
  AuthGuard({required Ref ref}) : _ref = ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    const String user = 'haha';

    if (user == 'haha') {
      resolver.next();
    } else {
      // router.replaceAll([const LoginScreenRoute()]);
    }
  }
}
