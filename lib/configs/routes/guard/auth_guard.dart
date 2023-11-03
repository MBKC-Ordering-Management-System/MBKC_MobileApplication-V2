import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/commons/functions/shared_preferences_utils.dart';
import '../../../utils/providers/common_provider.dart';
import '../app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref _ref;
  AuthGuard({required Ref ref}) : _ref = ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final userData = await SharedPreferencesUtils.getInstance('user_token');

    if (userData != null) {
      _ref.read(authProvider.notifier).update((state) => userData);
      resolver.next();
    } else {
      router.replaceAll([SignInScreenRoute()]);
    }
  }
}
