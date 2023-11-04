enum OrderSystemStatusType {
  instore('IN_STORE'),
  readydelivery('READY_DELIVERY'),
  completed('COMPLETED'),
  cancelled('CANCELLED');

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
