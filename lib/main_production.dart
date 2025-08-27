import 'package:finance_repository/finance_repository.dart';
import 'package:focuslab/app/app.dart';
import 'package:focuslab/bootstrap.dart';
import 'package:focuslab/new_home/widgets/fragment_provider.dart';

void main() {
  bootstrap(({
    required FinanceRepository financeRepository,
    required AnalogClockFragmentProvider clockFragmentProvider,
  }) {
    return App(
      financeRepository: financeRepository,
      clockFragmentProvider: clockFragmentProvider,
    );
  });
}
