import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/money_exchange_model.dart';

class MoneyExchangeItem extends StatelessWidget {
  const MoneyExchangeItem({super.key, required this.moneyExchange});
  final MoneyExchangeModel moneyExchange;

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
                '${moneyExchange.transactionTime} - ${getTitleTypeMoneyExchange(moneyExchange.exchangeType!)}',
            size: AssetsConstants.defaultFontSize - 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LabelText(
                  content: moneyExchange.content!,
                  size: AssetsConstants.defaultFontSize - 10.0,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
              LabelText(
                content: moneyExchange.exchangeType == MoneyExchangeType.receive
                    ? getCustomContent({'Tiền nhận:': moneyExchange.amount})
                    : getCustomContent({'Tiền tiền:': moneyExchange.amount}),
                size: AssetsConstants.defaultFontSize - 10.0,
                color: getColorMoneyExchange(moneyExchange.exchangeType!),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
