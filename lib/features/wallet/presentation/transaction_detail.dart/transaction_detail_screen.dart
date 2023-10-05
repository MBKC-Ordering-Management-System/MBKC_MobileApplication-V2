import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../domain/models/transaction_model.dart';
import 'transaction_field_item.dart';

@RoutePage()
class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key, required this.transaction});
  final TransactionModel transaction;

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
                TransactionFieldItem(
                  title: 'Ngày giao dịch',
                  content: transaction.date,
                ),
                SizedBox(height: size.height * 0.01),
                TransactionFieldItem(
                  title: 'Số tiền giao dịch',
                  content: getCustomContent({
                    'Số tiền giao dịch': transaction.amout,
                  }),
                ),
                SizedBox(height: size.height * 0.01),
                TransactionFieldItem(
                  title: 'Số dư sau giao dịch',
                  content: getCustomContent({
                    'Số dư sau giao dịch': transaction.balance,
                  }),
                ),
                SizedBox(height: size.height * 0.01),
                TransactionFieldItem(
                  title: 'Loại giao dịch',
                  content: transaction.type == TransactionType.moneyin
                      ? 'Tiền vào'
                      : 'Tiền ra',
                ),
                SizedBox(height: size.height * 0.01),
                TransactionFieldItem(
                  title: 'Trạng thái',
                  content: transaction.status,
                ),
                SizedBox(height: size.height * 0.01),
                TransactionFieldItem(
                  title: 'Nội dung',
                  content: transaction.content,
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
