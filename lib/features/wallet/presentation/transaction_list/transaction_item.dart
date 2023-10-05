import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AssetsConstants.defaultMargin),
      width: size.width * 1,
      height: size.height * 0.08,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AssetsConstants.borderColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelText(
            content:
                '${transaction.date} - ${getTitleTypeTransaction(transaction.type)}',
            size: AssetsConstants.defaultFontSize - 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LabelText(
                  content: transaction.content,
                  size: AssetsConstants.defaultFontSize - 10.0,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
              LabelText(
                content: transaction.type == TransactionType.moneyin
                    ? getCustomContent({'Tiền vào:': transaction.amout})
                    : getCustomContent({'Tiền ra:': transaction.amout}),
                size: AssetsConstants.defaultFontSize - 10.0,
                color: getColorTransaction(transaction.type),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
