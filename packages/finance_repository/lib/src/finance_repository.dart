import 'package:finance_repository/objectbox.g.dart';
import 'package:finance_repository/src/cost.dart';
import 'package:objectbox/objectbox.dart';

/// {@template finance_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FinanceRepository {
  /// {@macro finance_repository}
  FinanceRepository();

  late Box<Cost> _costBox;

  Future<void> initialize() async {
    final Store store = await openStore(directory: 'finance');
    _costBox = store.box<Cost>();
  }

  /// Adds a new cost to the repository.
  Future<void> addCost(Cost cost) async {
    cost.categoryValue = cost.category.value;
    await _costBox.putAsync(cost);
  }

  /// Retrieves all costs from the repository.
  Future<List<Cost>> getAllCosts() async {
    return _costBox.getAll();
  }
}
