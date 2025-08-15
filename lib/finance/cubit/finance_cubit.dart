import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:finance_repository/finance_repository.dart';
import 'package:meta/meta.dart';

part 'finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
  final FinanceRepository financeRepository;

  StreamSubscription<List<Cost>>? _costsSubscription;

  FinanceCubit({
    required this.financeRepository,
  }) : super(
          FinanceState(
            costs: financeRepository.costs.value,
            goals: calculateGoalsFromCosts(financeRepository.costs.value),
          ),
        ) {
    _costsSubscription = financeRepository.costs.listen(updateState);
  }

  void updateState(List<Cost> costs) {
    emit(
      FinanceState(
        costs: costs,
        goals: calculateGoalsFromCosts(costs),
      ),
    );
  }

  @override
  Future<void> close() {
    _costsSubscription?.cancel();
    return super.close();
  }
}

List<Goal> calculateGoalsFromCosts(List<Cost> costs) {
  Map<CostCategory, double> categoryTotals = {};
  for (var cost in costs) {
    categoryTotals[cost.category] =
        (categoryTotals[cost.category] ?? 0) + cost.amount;
  }
  // Implement your goal calculation logic here
  return [
    Goal(
        category: CostCategory.groceries,
        totalAmount: 1000,
        spent: categoryTotals[CostCategory.groceries] ?? 0),
    Goal(
        category: CostCategory.shopping,
        totalAmount: 500,
        spent: categoryTotals[CostCategory.shopping] ?? 0),
    Goal(
        category: CostCategory.transportation,
        totalAmount: 300,
        spent: categoryTotals[CostCategory.transportation] ?? 0),
    Goal(
        category: CostCategory.other,
        totalAmount: 400,
        spent: categoryTotals[CostCategory.other] ?? 0),
  ];
}
