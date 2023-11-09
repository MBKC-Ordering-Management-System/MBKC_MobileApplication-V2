import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/extensions/extensions_export.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/models/profile_model.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get profile
  Future<void> getProfile({
    required BuildContext context,
    required ValueNotifier<ProfileModel?> profile,
  }) async {
    state = const AsyncLoading();
    final profileRepository = ref.read(profileRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        profile.value = await profileRepository.getProfile(
          APIConstants.prefixToken + user!.token.accessToken,
        );
      },
    );

    // access expired || other error
    if (state.hasError) {
      state = await AsyncValue.guard(
        () async {
          final statusCode = (state.error as DioException).onStatusDio();
          await handleAPIError(
            statusCode: statusCode,
            stateError: state.error!,
            context: context,
            onCallBackGenerateToken: reGenerateToken(authRepository, context),
          );

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }

          await getProfile(context: context, profile: profile);
        },
      );

      // if refresh token expired
      if (state.hasError) {
        await authRepository.signOut();
        context.router.replaceAll([SignInScreenRoute()]);
      }
    }
  }
}
