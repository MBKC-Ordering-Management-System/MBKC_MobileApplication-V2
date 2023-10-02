import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/dummy_data/auth_dummy_data.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/profile_model.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends RemoteBaseRepository
    implements ProfileRepository {
  final bool addDelay;
  ProfileRepositoryImpl({this.addDelay = true});

  @override
  Future<ProfileModel> getProfile() async {
    await delay(addDelay);
    return AuthDummyData.profile;
  }
}
