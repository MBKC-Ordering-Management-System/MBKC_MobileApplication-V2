import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/commons/functions/api_utils.dart';
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
  Future<ProfileModel?> getProfile(
    BuildContext context,
  ) async {
    ProfileModel? profile;
    state = const AsyncLoading();
    final profileRepository = ref.read(profileRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        profile = await profileRepository.getProfile();
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
    }

    return profile;
  }
}
