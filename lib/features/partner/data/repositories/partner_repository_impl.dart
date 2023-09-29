import '../../../../models/request/paging_model.dart';
import '../../../../models/response/success_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/dummy_data/partner_dummy_data.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/partner_model.dart';
import '../../domain/models/request/partner_request.dart';
import '../../domain/repositories/partner_repository.dart';

class PartnerRepositoryImpl extends RemoteBaseRepository
    implements PartnerRepository {
  final bool addDelay;
  PartnerRepositoryImpl({this.addDelay = true});

  @override
  Future<List<PartnerModel>> getPartners({
    required PagingModel request,
  }) async {
    await delay(addDelay);
    return PartnerDummyData.partnersGenerate
        .skip((request.pageNumber - 1) * request.pageSize)
        .take(request.pageSize)
        .toList();
  }

  @override
  Future<SuccessModel> createPartner({required PartnerRequest request}) async {
    await delay(addDelay);
    return SuccessModel(message: 'Create successfully.');
  }

  @override
  Future<SuccessModel> updatePartner({
    required int id,
    required PartnerRequest request,
  }) async {
    await delay(addDelay);
    return SuccessModel(message: 'Update successfully.');
  }

  @override
  Future<SuccessModel> deletePartner({required int id}) async {
    await delay(addDelay);
    return SuccessModel(message: 'Delete successfully.');
  }
}
