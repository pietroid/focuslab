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
            goals: calculateGoalsFromCosts(financeRepository.costs.value,
                DateTime.now(), DateTime.now().add(Duration(days: 7))),
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 7)),
          ),
        ) {
    _costsSubscription = financeRepository.costs.listen(updateState);
  }

  void updateState(List<Cost> costs) {
    emit(
      FinanceState(
        costs: costs,
        goals: calculateGoalsFromCosts(costs, state.startDate, state.endDate),
        startDate: state.startDate,
        endDate: state.endDate,
      ),
    );
  }

  void updateDateRange(DateTime startDate, DateTime endDate) {
    emit(
      FinanceState(
        costs: state.costs,
        goals: calculateGoalsFromCosts(state.costs, startDate, endDate),
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  void removeCost(Cost cost) {
    financeRepository.removeCost(cost);
  }

  @override
  Future<void> close() {
    _costsSubscription?.cancel();
    return super.close();
  }
}

List<Goal> calculateGoalsFromCosts(
    List<Cost> costs, DateTime startDate, DateTime endDate) {
  final totalNumberOfDays = endDate.difference(startDate).inDays;
  final startDateMidnight =
      DateTime(startDate.year, startDate.month, startDate.day);
  final endDateMidnight = DateTime(endDate.year, endDate.month, endDate.day);
  Map<CostCategory, double> categoryTotals = {};
  for (var cost in costs) {
    if (cost.date.isAfter(startDateMidnight) &&
        cost.date.isBefore(endDateMidnight)) {
      categoryTotals[cost.category] =
          (categoryTotals[cost.category] ?? 0) + cost.amount;
    }
  }
  // Implement your goal calculation logic here
  return [
    Goal(
        category: CostCategory.groceries,
        totalAmount: 66.6 * totalNumberOfDays,
        spent: categoryTotals[CostCategory.groceries] ?? 0),
    Goal(
        category: CostCategory.shopping,
        totalAmount: 33.33 * totalNumberOfDays,
        spent: categoryTotals[CostCategory.shopping] ?? 0),
    Goal(
        category: CostCategory.transportation,
        totalAmount: 16.66 * totalNumberOfDays,
        spent: categoryTotals[CostCategory.transportation] ?? 0),
    Goal(
        category: CostCategory.other,
        totalAmount: 66.6 * totalNumberOfDays,
        spent: categoryTotals[CostCategory.other] ?? 0),
  ];
}
