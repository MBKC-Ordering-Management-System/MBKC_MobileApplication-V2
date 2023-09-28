import '../../constants/asset_constant.dart';
import '../../enums/enums_export.dart';

String getLogoPartner(PartnerType type) {
  switch (type) {
    case PartnerType.beamin:
      return AssetsConstants.beaminLogo;
    case PartnerType.grabfood:
      return AssetsConstants.grabLogo;
    case PartnerType.shopeefood:
      return AssetsConstants.shopeeLogo;
    default:
      return AssetsConstants.beaminLogo;
  }
}
