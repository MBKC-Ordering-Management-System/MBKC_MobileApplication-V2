enum OrderPartnerStatusType {
  preparing('PREPARING'),
  ready('READY'),
  upcoming('UPCOMING'),
  completed('COMPLETED'),
  cancelled('CANCELLED');

  final String type;
  const OrderPartnerStatusType(this.type);
}

extension ConvertOrderPartnerStatus on String {
  OrderPartnerStatusType toOrderPartnerTypeEnum() {
    switch (this) {
      case 'PREPARING':
        return OrderPartnerStatusType.preparing;
      case 'READY':
        return OrderPartnerStatusType.ready;
      case 'UPCOMING':
        return OrderPartnerStatusType.upcoming;
      case 'COMPLETED':
        return OrderPartnerStatusType.completed;
      case 'CANCELLED':
        return OrderPartnerStatusType.cancelled;
      default:
        return OrderPartnerStatusType.preparing;
    }
  }
}
