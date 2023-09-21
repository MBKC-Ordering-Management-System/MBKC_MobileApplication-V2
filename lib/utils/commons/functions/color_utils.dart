import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import '../../enums/order_status_type.dart';

Color getColorOrderStatus(OrderStatusType orderType) {
  switch (orderType) {
    case OrderStatusType.preparing:
      return AssetsConstants.preparingColor;
    case OrderStatusType.ready:
      return AssetsConstants.mainColor;
    case OrderStatusType.delivering:
      return AssetsConstants.deliveringColor;
    case OrderStatusType.delivered:
      return AssetsConstants.deliveredColor;
    case OrderStatusType.cancelled:
      return AssetsConstants.subtitleColor;
    default:
      return AssetsConstants.preparingColor;
  }
}
