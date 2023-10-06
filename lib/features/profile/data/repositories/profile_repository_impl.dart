import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/profile_model.dart';
import '../../domain/repositories/profile_repository.dart';
import '../remote/profile_source.dart';

class ProfileRepositoryImpl extends RemoteBaseRepository
    implements ProfileRepository {
  final ProfileSource _profileSource;
  final bool addDelay;
  ProfileRepositoryImpl(this._profileSource, {this.addDelay = true});

  @override
  Future<ProfileModel> getProfile(String accessToken) async {
    return getDataOf(
      request: () => _profileSource.getProfile(accessToken),
    );
  }
}
