enum OrderStatusType {
  preparing('Đang chuẩn bị'),
  ready('Sẵn sàng'),
  delivering('Đang giao'),
  delivered('Đã giao'),
  cancelled('Đã hủy');

  final String type;
  const OrderStatusType(this.type);
}

extension ConvertOrderStatus on String {
  OrderStatusType toOrderTypeEnum() {
    switch (this) {
      case 'preparing':
        return OrderStatusType.preparing;
      case 'ready':
        return OrderStatusType.ready;
      case 'delivering':
        return OrderStatusType.delivering;
      case 'delivered':
        return OrderStatusType.delivered;
      case 'cancelled':
        return OrderStatusType.cancelled;
      default:
        return OrderStatusType.preparing;
    }
  }
}
