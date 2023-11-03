import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import '../../enums/enums_export.dart';

Color getColorOrderStatus(OrderPartnerStatusType orderType) {
  switch (orderType) {
    case OrderPartnerStatusType.preparing:
      return AssetsConstants.preparingColor;
    case OrderPartnerStatusType.ready:
      return AssetsConstants.mainColor;
    case OrderPartnerStatusType.upcoming:
      return AssetsConstants.deliveringColor;
    case OrderPartnerStatusType.completed:
      return AssetsConstants.deliveredColor;
    case OrderPartnerStatusType.cancelled:
      return AssetsConstants.subtitleColor;
    default:
      return AssetsConstants.preparingColor;
  }
}

Color getColorPartner(PartnerType type) {
  switch (type) {
    case PartnerType.beamin:
      return AssetsConstants.beaminColor;
    case PartnerType.grabfood:
      return AssetsConstants.grabColor;
    case PartnerType.shopeefood:
      return AssetsConstants.shopeeColor;
    default:
      return AssetsConstants.beaminColor;
  }
}

Color getColorTransaction(TransactionType type) {
  switch (type) {
    case TransactionType.moneyin:
      return AssetsConstants.transactionIn;
    case TransactionType.moneyout:
      return AssetsConstants.transactionOut;
    default:
      return AssetsConstants.transactionIn;
  }
}
