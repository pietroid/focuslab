import 'package:finance_repository/finance_repository.dart';
import 'package:focuslab/app/app.dart';
import 'package:focuslab/bootstrap.dart';

void main() {
  bootstrap(({
    required FinanceRepository financeRepository,
  }) {
    return App(financeRepository: financeRepository);
  });
}
