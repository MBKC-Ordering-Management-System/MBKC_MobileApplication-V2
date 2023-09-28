import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../domain/models/partner_model.dart';
import '../../domain/repositories/partner_repository.dart';

part 'partner_controller.g.dart';

@riverpod
class PartnerController extends _$PartnerController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get partners
  Future<List<PartnerModel>> getPartners(
    PagingModel request,
    BuildContext context,
  ) async {
    List<PartnerModel> partners = [];
    state = const AsyncLoading();
    final partnerRepository = ref.read(partnerRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        partners = await partnerRepository.getPartners(request: request);
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
    }

    return partners;
  }
}
