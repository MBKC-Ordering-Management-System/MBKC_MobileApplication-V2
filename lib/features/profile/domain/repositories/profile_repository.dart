import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../models/profile_model.dart';

part 'profile_repository.g.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl();
}
