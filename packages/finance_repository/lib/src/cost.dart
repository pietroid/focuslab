import 'package:objectbox/objectbox.dart';

@Entity()
class Cost {
  Cost({
    required this.amount,
    this.description,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  @Id()
  int id = 0;

  /// Amount of the cost in the specified currency.
  double amount;

  /// Description of the cost.
  String? description;

  /// Category of the cost.
  @Transient()
  late CostCategory category;

  /// Date when the cost was made.
  @Property(type: PropertyType.date)
  final DateTime date;

  String get categoryValue => category.value;

  set categoryValue(String value) {
    category = CostCategory.values.firstWhere((e) => e.value == value);
  }
}

enum CostCategory {
  groceries('groceries'),
  shopping('shopping'),
  transportation('transportation'),
  other('other');

  final String value;
  const CostCategory(this.value);
}
