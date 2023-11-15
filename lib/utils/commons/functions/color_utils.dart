import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import '../../enums/enums_export.dart';

Color getBackgroundColorPartnerStatus(OrderPartnerStatusType orderType) {
  switch (orderType) {
    case OrderPartnerStatusType.preparing:
      return AssetsConstants.secondaryLighter;
    case OrderPartnerStatusType.ready:
      return AssetsConstants.warningLighter;
    case OrderPartnerStatusType.upcoming:
      return AssetsConstants.secondaryLighter;
    case OrderPartnerStatusType.completed:
      return AssetsConstants.successLighter;
    case OrderPartnerStatusType.cancelled:
      return AssetsConstants.errorLighter;
    default:
      return AssetsConstants.secondaryLighter;
  }
}

Color getContentColorPartnerStatus(OrderPartnerStatusType orderType) {
  switch (orderType) {
    case OrderPartnerStatusType.preparing:
      return AssetsConstants.secondaryDark;
    case OrderPartnerStatusType.ready:
      return AssetsConstants.warningDarker;
    case OrderPartnerStatusType.upcoming:
      return AssetsConstants.secondaryDark;
    case OrderPartnerStatusType.completed:
      return AssetsConstants.successDarker;
    case OrderPartnerStatusType.cancelled:
      return AssetsConstants.errorDark;
    default:
      return AssetsConstants.secondaryDark;
  }
}

// system ---

Color getBackgroundColorSystemStatus(OrderSystemStatusType orderType) {
  switch (orderType) {
    case OrderSystemStatusType.instore:
      return AssetsConstants.primaryLighter;
    case OrderSystemStatusType.readydelivery:
      return AssetsConstants.warningLighter;
    case OrderSystemStatusType.completed:
      return AssetsConstants.successLighter;
    case OrderSystemStatusType.cancelled:
      return AssetsConstants.errorLighter;
    default:
      return AssetsConstants.primaryLighter;
  }
}

Color getContentColorSystemStatus(OrderSystemStatusType orderType) {
  switch (orderType) {
    case OrderSystemStatusType.instore:
      return AssetsConstants.primaryDark;
    case OrderSystemStatusType.readydelivery:
      return AssetsConstants.warningDarker;
    case OrderSystemStatusType.completed:
      return AssetsConstants.successDarker;
    case OrderSystemStatusType.cancelled:
      return AssetsConstants.errorDark;
    default:
      return AssetsConstants.primaryDark;
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

Color getColorMoneyExchange(MoneyExchangeType type) {
  switch (type) {
    case MoneyExchangeType.receive:
      return AssetsConstants.transactionIn;
    case MoneyExchangeType.withdraw:
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

    case 'Hoàn thành':
      return AssetsConstants.completedColor;

    case 'Đã hủy':
      return AssetsConstants.subtitleColor;

    case 'Thanh toán của giao hàng':
      return AssetsConstants.mainColor;

    default:
      return AssetsConstants.blackColor;
  }
}

Color getBackgrounStatusColor(StatusTypeEnum type) {
  switch (type) {
    case StatusTypeEnum.active:
      return AssetsConstants.successLighter;
    case StatusTypeEnum.inactive:
      return AssetsConstants.warningLighter;
    case StatusTypeEnum.deactive:
      return AssetsConstants.warningLighter;
    default:
      return AssetsConstants.successLighter;
  }
}

Color getContentStatusColor(StatusTypeEnum type) {
  switch (type) {
    case StatusTypeEnum.active:
      return AssetsConstants.successDark;
    case StatusTypeEnum.inactive:
      return AssetsConstants.warningDark;
    case StatusTypeEnum.deactive:
      return AssetsConstants.warningDark;
    default:
      return AssetsConstants.successDark;
  }
}
