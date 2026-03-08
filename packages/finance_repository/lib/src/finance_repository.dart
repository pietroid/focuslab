import 'package:finance_repository/objectbox.g.dart';
import 'package:finance_repository/src/cost.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

/// {@template finance_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FinanceRepository {
  /// {@macro finance_repository}
  FinanceRepository();

  late Box<Cost> _costBox;
  late BehaviorSubject<List<Cost>> _costListSubject;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(dir.path, 'finance'),
    );
    _costBox = store.box<Cost>();
    _setupCostList();
  }

  void _setupCostList() {
    final sortedList = _costBox.getAll()
      ..sort((a, b) => b.date.compareTo(a.date));
    _costListSubject = BehaviorSubject.seeded(sortedList);
    _costBox.query().watch(triggerImmediately: true).listen((query) {
      final sortedList = _costBox.getAll()
        ..sort((a, b) => b.date.compareTo(a.date));
      _costListSubject.add(sortedList);
    });
  }

  /// Adds a new cost to the repository.
  Future<void> addCost(Cost cost) async {
    cost.categoryValue = cost.category.value;
    await _costBox.putAsync(cost);
  }

  /// Removes a cost from the repository.
  Future<void> removeCost(Cost cost) async {
    _costBox.remove(cost.id);
  }

  /// Retrieves all costs from the repository.
  BehaviorSubject<List<Cost>> get costs => _costListSubject;
}
