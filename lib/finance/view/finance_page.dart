import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/finance/widget/finance_goal.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        body: Column(children: const [
          FinanceGoal(
            title: 'Mercado',
            totalAmount: 5000.00,
            spent: 3000.00,
          ),
        ]),
        title: 'Finanças');
  }
}
