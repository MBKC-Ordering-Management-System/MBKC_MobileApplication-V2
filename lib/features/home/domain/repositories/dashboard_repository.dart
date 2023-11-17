import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/remote/dashboard_source.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../models/dashboard_model.dart';

part 'dashboard_repository.g.dart';

abstract class DashboardRepository {
  Future<DashBoardModel> getStoreDashboard({
    required String accessToken,
  });
}

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(
  DashboardRepositoryRef ref,
) {
  final dashboardSource = ref.read(dashboardSourceProvider);
  return DashboardRepositoryImpl(dashboardSource);
}
