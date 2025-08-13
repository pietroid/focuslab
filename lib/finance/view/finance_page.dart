import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/finance/widget/finance_goal.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.large,
            horizontal: AppSpacing.large,
          ),
          child: Column(children: const [
            FinanceGoal(
              title: '🍎 Mercado',
              totalAmount: 444.0,
              spent: 200.00,
            ),
            SizedBox(height: AppSpacing.large),
            FinanceGoal(
              title: '🛒 Compras',
              totalAmount: 111.00,
              spent: 100.00,
            ),
            SizedBox(height: AppSpacing.large),
            FinanceGoal(
              title: '🛻 99/Uber',
              totalAmount: 111.00,
              spent: 100.00,
            ),
            SizedBox(height: AppSpacing.large),
            FinanceGoal(
              title: 'Outros',
              totalAmount: 111.00,
              spent: 100.00,
            ),
          ]),
        ),
        title: 'Finanças');
  }
}
