class DebtItem {
  final String title;
  final double interestRate;
  final double principal;
  // In months
  final int timePeriod;
  final double numberOfInstallments;
  final String id;

  DebtItem({
    required this.id,
    required this.title,
    required this.interestRate,
    required this.principal,
    required this.timePeriod,
    required this.numberOfInstallments,
  });

  static DebtItem fromMap(Map data, String id) {
    return DebtItem(
      numberOfInstallments: data['installment'],
      interestRate: data['interest'],
      principal: data['principal'],
      timePeriod: data['interval'],
      title: data['name'],
      id: id,
    );
  }
}
