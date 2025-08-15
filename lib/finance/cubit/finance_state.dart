part of 'finance_cubit.dart';

@immutable
class FinanceState {
  const FinanceState({
    required this.costs,
    required this.goals,
    required this.startDate,
    required this.endDate,
  });

  final List<Cost> costs;
  final List<Goal> goals;
  final DateTime startDate;
  final DateTime endDate;
}

class Goal {
  const Goal({
    required this.category,
    required this.totalAmount,
    required this.spent,
  });

  final CostCategory category;
  final double totalAmount;
  final double spent;
}
