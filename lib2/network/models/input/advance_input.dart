class AdvanceInput {
  final double amount;
  final String description;
  final int installmentPeriod;

  const AdvanceInput({
    required this.amount,
    required this.description,
    required this.installmentPeriod,
  });

  Map<String, dynamic> get toJson => {
        "amount": amount,
        "description": description,
        "installmentPeriod": installmentPeriod,
      };
}
