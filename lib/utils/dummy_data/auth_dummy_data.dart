import '../../features/profile/domain/models/brand_model.dart';
import '../../features/profile/domain/models/kitchen_center_model.dart';
import '../../features/profile/domain/models/profile_model.dart';

class AuthDummyData {
  static const emailExist = 'test@gmail.com';
  static const passwordExis = '12345678';
  static const otpCode = '000000';
  static ProfileModel profile = ProfileModel(
    storeId: 1,
    name: 'Bếp cả chá',
    status: 'active',
    logo: '',
    storeManagerEmail: 'blacksky01102001@gmail.com',
    rejectedReason: 'ngu',
    kitchenCenter: KitchenCenterModel(
      kitchenCenterId: 1,
      name: 'TP Thủ Đức',
      address: '64/33, Đường hàng tre, TP Thủ Đức',
      status: 'active',
      logo: '',
      kitchenCenterManagerEmail: 'lehongthanhhy@gmail.com',
    ),
    brand: BrandModel(
      brandId: 1,
      name: 'Highland',
      address: '64/33, Đường hàng tre',
      logo: '',
      status: 'active',
      brandManagerEmail: 'blacksky2k1@gmail.com',
    ),
  );
}
