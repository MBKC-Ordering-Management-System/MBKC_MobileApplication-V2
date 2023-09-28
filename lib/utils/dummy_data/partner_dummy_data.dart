import 'package:faker/faker.dart';
import '../../features/partner/domain/models/partner_model.dart';
import '../enums/enums_export.dart';

class PartnerDummyData {
  static final partnersGenerate = List.generate(
    3,
    (index) => PartnerModel(
      id: index + 1,
      username: faker.person.name(),
      password: faker.internet.password(),
      type: index + 1 == 1
          ? PartnerType.grabfood
          : index + 1 == 2
              ? PartnerType.beamin
              : PartnerType.shopeefood,
    ),
  );
}
