enum TransactionType {
  all(0),
  moneyin(1),
  moneyout(2);

  final int type;
  const TransactionType(this.type);
}

extension ConvertTransaction on int {
  TransactionType toTransactionTypeEnum() {
    switch (this) {
      case 0:
        return TransactionType.all;
      case 1:
        return TransactionType.moneyin;
      case 2:
        return TransactionType.moneyout;
      default:
        return TransactionType.all;
    }
  }
}
