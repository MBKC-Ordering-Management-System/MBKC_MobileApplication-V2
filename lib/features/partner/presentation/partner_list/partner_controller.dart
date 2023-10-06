import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/snack_bar.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
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
      handleAPIError(
        statusCode: StatusCodeType.badrequest.type,
        stateError: state.error!,
        context: context,
      );
    }

    return partners;
  }

  // delete partner
  void deletePartner(
    int id,
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    final partnerRepository = ref.read(partnerRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        await partnerRepository.deletePartner(id: id);
        showSnackBar(
          context: context,
          content: 'Xóa thành công',
          icon: AssetsConstants.iconSuccess,
          backgroundColor: AssetsConstants.mainColor,
          textColor: AssetsConstants.whiteColor,
        );

        if (context.mounted) {
          context.router.pop(true);
        }
      },
    );

    if (state.hasError) {
      handleAPIError(
        statusCode: StatusCodeType.badrequest.type,
        stateError: state.error!,
        context: context,
      );
    }
  }
}
