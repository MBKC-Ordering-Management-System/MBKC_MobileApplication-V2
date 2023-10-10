// ignore_for_file: unused_field
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/commons/functions/shared_preferences_utils.dart';
import '../app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref _ref;
  AuthGuard({required Ref ref}) : _ref = ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final token = await SharedPreferencesUtils.getInstance('user_token');

    if (token != null) {
      resolver.next();
    } else {
      router.replaceAll([SignInScreenRoute()]);
    }
  }
}
