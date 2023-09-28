enum PartnerType {
  shopeefood(0),
  beamin(1),
  grabfood(2);

  final int type;
  const PartnerType(this.type);
}

extension ConvertPartner on int {
  PartnerType toPartnerTypeEnum() {
    switch (this) {
      case 0:
        return PartnerType.shopeefood;
      case 1:
        return PartnerType.beamin;
      case 2:
        return PartnerType.grabfood;

      default:
        return PartnerType.shopeefood;
    }
  }
}
