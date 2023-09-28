import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/enums/modify_partner_type.dart';
import '../../domain/models/partner_model.dart';

@RoutePage()
class PartnerModifyScreen extends StatelessWidget {
  const PartnerModifyScreen({
    super.key,
    this.partner,
    required this.type,
  });
  final ModifyPartnerType type;
  final PartnerModel? partner;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
    );
  }
}
