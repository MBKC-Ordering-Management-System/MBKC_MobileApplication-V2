import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../domain/models/banking_account_model.dart';
import 'banking_account_controller.dart';

class BankingAccountItem extends ConsumerWidget {
  const BankingAccountItem({
    super.key,
    required this.account,
    required this.isFirst,
    required this.onCallBack,
  });
  final BankingAccountModel account;
  final bool isFirst;
  final VoidCallback onCallBack;

  // on delete
  void deleteAccount({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final result = await ref
        .read(bankingAccountControllerProvider.notifier)
        .deleteBankingAccount(account.id, context);
    if (result) {
      onCallBack();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      confirmDismiss: (DismissDirection direction) async =>
          await showAlertDialog(
        context: context,
        title: 'Xác nhận',
        content: 'Bạn có chắc muốn xóa tài khoản?',
        cancelActionText: 'Hủy',
      ),
      onDismissed: (_) => deleteAccount(context: context, ref: ref),
      background: Container(
        padding: const EdgeInsets.only(
          right: AssetsConstants.defaultPadding - 10.0,
        ),
        margin: const EdgeInsets.only(
          bottom: AssetsConstants.defaultMargin - 2.0,
        ),
        decoration: BoxDecoration(
          color: AssetsConstants.warningColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      child: Container(
        margin: EdgeInsets.only(
          bottom: AssetsConstants.defaultMargin - 2.0,
          top: isFirst
              ? AssetsConstants.defaultMargin - 2.0
              : AssetsConstants.defaultMargin - 10.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AssetsConstants.subtitleColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(AssetsConstants.appLogo),
          ),
          title: LabelText(
            content: '${account.name} - ${account.id}',
            size: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.bold,
          ),
          subtitle: LabelText(
            content: account.numberAccount,
            size: AssetsConstants.defaultFontSize - 14.0,
            fontWeight: FontWeight.w600,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_square,
              color: AssetsConstants.blackColor,
              size: AssetsConstants.defaultFontSize - 8.0,
            ),
          ),
        ),
      ),
    );
  }
}
