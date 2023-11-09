import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/money_exchange_model.dart';
import 'money_exchange_field_item.dart';

@RoutePage()
class MoneyExchangeDetailScreen extends StatelessWidget {
  const MoneyExchangeDetailScreen({super.key, required this.moneyExchange});
  final MoneyExchangeModel moneyExchange;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AssetsConstants.scaffoldColor,
      appBar: const CustomAppBar(
        backButtonColor: AssetsConstants.whiteColor,
        title: 'Thông Tin Giao Dịch',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AssetsConstants.defaultPadding - 6.0,
          vertical: AssetsConstants.defaultPadding - 6.0,
        ),
        child: FittedBox(
          child: Container(
            width: size.width * 1,
            padding: const EdgeInsets.all(
              AssetsConstants.defaultPadding - 10.0,
            ),
            decoration: BoxDecoration(
              color: AssetsConstants.whiteColor,
              border: Border.all(
                color: AssetsConstants.borderColor,
              ),
              borderRadius:
                  BorderRadius.circular(AssetsConstants.defaultBorder),
            ),
            child: Column(
              children: [
                MoneyExchangeFieldItem(
                  title: 'Ngày giao dịch',
                  content: formatDateTime(moneyExchange.transactionTime!),
                ),
                SizedBox(height: size.height * 0.01),
                MoneyExchangeFieldItem(
                  title: 'Số tiền giao dịch',
                  content: getCustomContent({
                    'Số tiền giao dịch': moneyExchange.amount,
                  }),
                ),
                SizedBox(height: size.height * 0.01),
                MoneyExchangeFieldItem(
                  title: 'Loại giao dịch',
                  content:
                      moneyExchange.exchangeType == MoneyExchangeType.receive
                          ? 'Tiền nhận'
                          : 'Tiền rút',
                ),
                SizedBox(height: size.height * 0.01),
                MoneyExchangeFieldItem(
                  title: 'Trạng thái',
                  content: getTitleStatusMoneyExchange(moneyExchange.status!),
                ),
                SizedBox(height: size.height * 0.01),
                MoneyExchangeFieldItem(
                  title: 'Nội dung',
                  content: getContentMoneyExchange(moneyExchange.exchangeType!),
                ),
                SizedBox(height: size.height * 0.01),
                MoneyExchangeFieldItem(
                  title: 'Người gửi',
                  content: moneyExchange.senderName!,
                ),
                SizedBox(height: size.height * 0.01),
                MoneyExchangeFieldItem(
                  title: 'Người nhận',
                  content: moneyExchange.receiveName!,
                ),
                SizedBox(height: size.height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
