import 'brand_model.dart';
import 'kitchen_center_model.dart';

class ProfileModel {
  final int storeId;
  final String name;
  final String status;
  final String logo;
  final String storeManagerEmail;
  final String rejectedReason;
  final KitchenCenterModel kitchenCenter;
  final BrandModel brand;

  ProfileModel({
    required this.storeId,
    required this.name,
    required this.status,
    required this.logo,
    required this.storeManagerEmail,
    required this.rejectedReason,
    required this.kitchenCenter,
    required this.brand,
  });
}
