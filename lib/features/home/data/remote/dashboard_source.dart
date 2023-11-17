import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/dashboard_model.dart';

part 'dashboard_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class DashboardSource {
  factory DashboardSource(Dio dio, {String baseUrl}) = _DashboardSource;

  @GET(APIConstants.dashboard)
  Future<HttpResponse<DashBoardModel>> getStoreDashboard(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
  );
}

@riverpod
DashboardSource dashboardSource(DashboardSourceRef ref) {
  final dio = ref.read(dioProvider);
  return DashboardSource(dio);
}
