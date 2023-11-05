import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import '../../enums/enums_export.dart';
import '../../enums/order_system_status_type.dart';

Color getColorOrderPartnerStatus(OrderPartnerStatusType orderType) {
  switch (orderType) {
    case OrderPartnerStatusType.preparing:
      return AssetsConstants.preparingColor;
    case OrderPartnerStatusType.ready:
      return AssetsConstants.mainColor;
    case OrderPartnerStatusType.upcoming:
      return AssetsConstants.upcomingColor;
    case OrderPartnerStatusType.completed:
      return AssetsConstants.completedColor;
    case OrderPartnerStatusType.cancelled:
      return AssetsConstants.subtitleColor;
    default:
      return AssetsConstants.preparingColor;
  }
}

Color getColorOrderSystemStatus(OrderSystemStatusType orderType) {
  switch (orderType) {
    case OrderSystemStatusType.instore:
      return AssetsConstants.preparingColor;
    case OrderSystemStatusType.readydelivery:
      return AssetsConstants.mainColor;
    case OrderSystemStatusType.completed:
      return AssetsConstants.completedColor;
    case OrderSystemStatusType.cancelled:
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

Color getColorByKey(String key) {
  switch (key) {
    case 'Trong bếp':
    case 'Đang chuẩn bị':
      return AssetsConstants.preparingColor;

    case 'Sẵn sàng':
    case 'Sẵn sàng giao':
      return AssetsConstants.mainColor;

    case 'Đặt trước':
      return AssetsConstants.upcomingColor;

    case 'Đã giao':
      return AssetsConstants.completedColor;

    case 'Đã hủy':
      return AssetsConstants.subtitleColor;

    case 'Thanh toán của giao hàng':
      return AssetsConstants.mainColor;

    case 'Giảm giá:':
      return AssetsConstants.discountColor;

    default:
      return AssetsConstants.blackColor;
  }
}
