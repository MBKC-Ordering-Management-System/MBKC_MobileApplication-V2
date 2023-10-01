import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../models/response/success_model.dart';
import '../../data/repositories/partner_repository_impl.dart';
import '../models/partner_model.dart';
import '../models/request/partner_request.dart';

part 'partner_repository.g.dart';

abstract class PartnerRepository {
  Future<List<PartnerModel>> getPartners({required PagingModel request});

  Future<SuccessModel> createPartner({required PartnerRequest request});

  Future<SuccessModel> updatePartner({
    required int id,
    required PartnerRequest request,
  });

  Future<SuccessModel> deletePartner({required int id});
}

@Riverpod(keepAlive: true)
PartnerRepository partnerRepository(PartnerRepositoryRef ref) {
  return PartnerRepositoryImpl();
}
