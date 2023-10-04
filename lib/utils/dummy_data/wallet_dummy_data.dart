import 'package:faker/faker.dart';
import '../../features/wallet/domain/models/banking_account_model.dart';
import '../../features/wallet/domain/models/transaction_model.dart';
import '../enums/transaction_type_enum.dart';

class WalletDummyData {
  static final transactionsGenerate = List.generate(
    60,
    (index) => TransactionModel(
      id: index + 1,
      amout: faker.randomGenerator.integer(120000, min: 10000),
      balance: faker.randomGenerator.integer(120000, min: 10000),
      from: faker.person.name(),
      to: faker.person.name(),
      date: '04/10/2023',
      type: index % 2 == 0 ? TransactionType.moneyin : TransactionType.moneyout,
      status: index % 2 == 0 ? 'Thành công' : 'Thất bại',
      content: 'Hôm qua em đẹp lắm',
    ),
  );

  static final bankingAccountsGenerate = List.generate(
    60,
    (index) => BankingAccountModel(
      id: index + 1,
      numberAccount: '0937 4738 4738 4838',
      name: index % 2 == 0 ? 'Argibank' : 'TPBank',
      logoUrl: index % 2 == 0 ? 'HIHI' : 'HAHA',
    ),
  );
}
