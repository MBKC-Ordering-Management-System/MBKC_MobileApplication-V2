import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/snack_bar.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/modify_type.dart';
import '../../domain/models/request/partner_request.dart';
import '../../domain/repositories/partner_repository.dart';

part 'partner_modify_controller.g.dart';

@riverpod
class PartnerModifyController extends _$PartnerModifyController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // update
  void modifyPartner(
    int? id,
    PartnerRequest partner,
    BuildContext context,
    ModifyType type,
  ) async {
    state = const AsyncLoading();
    final partnerRepository = ref.read(partnerRepositoryProvider);

    state = await AsyncValue.guard(
      () async {
        if (type == ModifyType.create) {
          await partnerRepository.createPartner(request: partner);
        } else {
          await partnerRepository.updatePartner(id: id!, request: partner);
        }
      },
    );

    if (state.hasError) {
      handleAPIError(stateError: state.error!, context: context);
      return;
    }

    if (type == ModifyType.create) {
      showSnackBar(
        context: context,
        content: 'Tạo mới thành công',
        icon: AssetsConstants.iconSuccess,
        backgroundColor: AssetsConstants.mainColor,
        textColor: AssetsConstants.whiteColor,
      );
    } else {
      showSnackBar(
        context: context,
        content: 'Cập nhật thành công',
        icon: AssetsConstants.iconSuccess,
        backgroundColor: AssetsConstants.mainColor,
        textColor: AssetsConstants.whiteColor,
      );
    }

    if (context.mounted) {
      context.router.pop(true);
    }
  }
}
