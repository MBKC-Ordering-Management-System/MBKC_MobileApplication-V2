import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../data/repositories/partner_repository_impl.dart';
import '../models/partner_model.dart';

part 'partner_repository.g.dart';

abstract class PartnerRepository {
  Future<List<PartnerModel>> getPartners({required PagingModel request});
}

@Riverpod(keepAlive: true)
PartnerRepository partnerRepository(PartnerRepositoryRef ref) {
  return PartnerRepositoryImpl();
}
