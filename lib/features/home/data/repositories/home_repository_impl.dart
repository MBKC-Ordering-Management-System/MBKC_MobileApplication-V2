import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/dummy_data/home_dummy_data.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/statistical_model.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends RemoteBaseRepository
    implements HomeRepository {
  final bool addDelay;
  HomeRepositoryImpl({this.addDelay = true});

  @override
  Future<StatisticalModel> getDataStatistical() async {
    await delay(addDelay);
    return HomeDummyData.statisticalModel;
  }
}
