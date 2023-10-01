import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import 'box_card.dart';

@RoutePage()
class WalletScreen extends HookConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: const CustomAppBar(
        title: 'Ví',
        backButtonColor: AssetsConstants.whiteColor,
      ),
      body: SingleChildScrollView(
        child: Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AssetsConstants.defaultPadding - 6.0,
            ),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                StatisticalCard(
                  backgroundColor: AssetsConstants.revenueBackground,
                  contentColor: AssetsConstants.mainColor,
                  icon: const Icon(
                    Icons.wallet,
                    color: AssetsConstants.mainColor,
                  ),
                  title: getCustomContent({'Giá:': 5000000}),
                  subtitle: 'Số dư tài khoản',
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.router.push(const BankingAccountScreenRoute());
                      },
                      child: const BoxCard(
                        backgroundColor:
                            AssetsConstants.accountBankingBackgroundColor,
                        contentColor: AssetsConstants.accountBankingContent,
                        icon: Icons.account_balance,
                        content: 'Tài khoản ngân hàng',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.router.push(const TransactionScreenRoute());
                      },
                      child: const BoxCard(
                        backgroundColor:
                            AssetsConstants.transactionBackgroundColor,
                        contentColor: AssetsConstants.transactionContent,
                        icon: Icons.history_sharp,
                        content: 'Lịch sử giao dịch',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
