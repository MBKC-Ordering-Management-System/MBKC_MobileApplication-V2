enum MoneyExchangeType {
  all(''),
  receive('RECEIVE'),
  withdraw('WITHDRAW');

  final String type;
  const MoneyExchangeType(this.type);
}

extension ConvertMoneyExchangeType on String {
  MoneyExchangeType toMoneyExchangeTypeEnum() {
    switch (this) {
      case 'RECEIVE':
        return MoneyExchangeType.receive;
      case 'WITHDRAW':
        return MoneyExchangeType.withdraw;
      default:
        return MoneyExchangeType.receive;
    }
  }
}
