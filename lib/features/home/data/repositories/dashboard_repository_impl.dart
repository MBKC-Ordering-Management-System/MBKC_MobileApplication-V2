import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/dashboard_model.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../remote/dashboard_source.dart';

class DashboardRepositoryImpl extends RemoteBaseRepository
    implements DashboardRepository {
  final DashboardSource _dashboardSource;
  DashboardRepositoryImpl(this._dashboardSource);

  @override
  Future<DashBoardModel> getStoreDashboard({required String accessToken}) {
    return getDataOf(
      request: () => _dashboardSource.getStoreDashboard(
        APIConstants.contentType,
        accessToken,
      ),
    );
  }
}
