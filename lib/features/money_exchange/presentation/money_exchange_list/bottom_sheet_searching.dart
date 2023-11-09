import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import 'money_exchange_screen.dart';

final optionsMoneyExchangeType = [
  MoneyExchangeType.all,
  MoneyExchangeType.receive,
  MoneyExchangeType.withdraw,
];

final moneyExchangeTypeProvider = StateProvider.autoDispose<MoneyExchangeType>(
  (ref) => MoneyExchangeType.all,
);

showBottomSheetSearching({
  required BuildContext context,
  required Size size,
  required VoidCallback onCallback,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AssetsConstants.defaultPadding - 10.0,
        ),
        height: size.height * 0.7,
        width: size.width * 1,
        decoration: const BoxDecoration(
          color: AssetsConstants.scaffoldColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AssetsConstants.defaultBorder + 10.0),
            topRight: Radius.circular(AssetsConstants.defaultBorder + 10.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.filter_alt_rounded,
                        color: AssetsConstants.blackColor,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      const LabelText(
                        content: 'Lọc',
                        size: AssetsConstants.defaultFontSize - 10.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => context.router.pop(),
                    icon: const Icon(
                      Icons.close,
                      color: AssetsConstants.blackColor,
                    ),
                  )
                ],
              ),
              Consumer(
                builder: (_, ref, __) => SearchTimeBox(
                  searchType: SearchDateType.transactionsearch,
                  dateFrom: ref.watch(transactionDateFrom),
                  dateTo: ref.watch(transactionDateTo),
                  borderColor: AssetsConstants.borderColor,
                  title: 'Tra cứu lịch sử giao dịch',
                  icon: Icons.shopping_bag_rounded,
                  contentColor: AssetsConstants.blackColor,
                  backGroundColor: AssetsConstants.whiteColor,
                  onCallBack: () {
                    onCallback();
                    context.router.pop();
                  },
                ),
              ),
              SizedBox(height: size.height * 0.01),
              const LabelText(
                content: 'Loại giao dịch',
                fontWeight: FontWeight.w600,
                size: AssetsConstants.defaultFontSize - 10.0,
              ),
              SizedBox(height: size.height * 0.01),
              Consumer(
                builder: (_, ref, __) => Container(
                  decoration: BoxDecoration(
                    color: AssetsConstants.revenueBackground,
                    border: Border.all(
                      color: AssetsConstants.mainColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      AssetsConstants.defaultBorder,
                    ),
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        title: LabelText(
                          content: getTitleMoneyExchangeType(
                            MoneyExchangeType.all,
                          ),
                          size: AssetsConstants.defaultFontSize - 10.0,
                        ),
                        value: optionsMoneyExchangeType[0],
                        groupValue: ref.watch(moneyExchangeTypeProvider),
                        onChanged: (val) {
                          ref
                              .read(moneyExchangeTypeProvider.notifier)
                              .update((state) => optionsMoneyExchangeType[0]);
                        },
                        activeColor: AssetsConstants.mainColor,
                      ),
                      RadioListTile(
                        title: LabelText(
                          content: getTitleMoneyExchangeType(
                            MoneyExchangeType.receive,
                          ),
                          size: AssetsConstants.defaultFontSize - 10.0,
                        ),
                        value: optionsMoneyExchangeType[1],
                        groupValue: ref.watch(moneyExchangeTypeProvider),
                        onChanged: (val) {
                          ref
                              .read(moneyExchangeTypeProvider.notifier)
                              .update((state) => optionsMoneyExchangeType[1]);
                        },
                        activeColor: AssetsConstants.mainColor,
                      ),
                      RadioListTile(
                        title: LabelText(
                          content: getTitleMoneyExchangeType(
                              MoneyExchangeType.withdraw),
                          size: AssetsConstants.defaultFontSize - 10.0,
                        ),
                        value: optionsMoneyExchangeType[2],
                        groupValue: ref.watch(moneyExchangeTypeProvider),
                        onChanged: (val) {
                          ref
                              .read(moneyExchangeTypeProvider.notifier)
                              .update((state) => optionsMoneyExchangeType[2]);
                        },
                        activeColor: AssetsConstants.mainColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
