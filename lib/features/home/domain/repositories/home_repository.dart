import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../models/statistical_model.dart';

part 'home_repository.g.dart';

abstract class HomeRepository {
  Future<StatisticalModel> getDataStatistical();
}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl();
}

@riverpod
Future<StatisticalModel> getStatisticalData(GetStatisticalDataRef ref) {
  final homeRepository = ref.read(homeRepositoryProvider);
  return homeRepository.getDataStatistical();
}
