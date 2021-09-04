class DebtItem {
  final String title;
  final double interestRate;
  final double principal;
  // In months
  final int timePeriod;
  final double firstInstallation;

  DebtItem({
    required this.title,
    required this.interestRate,
    required this.principal,
    required this.timePeriod,
    required this.firstInstallation,
  });
}
