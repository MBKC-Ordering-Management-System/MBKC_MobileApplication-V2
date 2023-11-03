enum OrderSystemStatusType {
  instore('Đang chuẩn bị'),
  readydelivery('Sẵn sàng'),
  completed('Đã giao'),
  cancelled('Đã hủy');

  final String type;
  const OrderSystemStatusType(this.type);
}

extension ConvertOrderSystemStatus on String {
  OrderSystemStatusType toOrderSystemTypeEnum() {
    switch (this) {
      case 'IN_STORE':
        return OrderSystemStatusType.instore;
      case 'READY_DELIVERY':
        return OrderSystemStatusType.readydelivery;
      case 'COMPLETED':
        return OrderSystemStatusType.completed;
      case 'CANCELLED':
        return OrderSystemStatusType.cancelled;
      default:
        return OrderSystemStatusType.instore;
    }
  }
}
