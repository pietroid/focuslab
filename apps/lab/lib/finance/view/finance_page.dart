import 'package:app_ui/app_ui.dart';
import 'package:finance_repository/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/finance/cubit/finance_cubit.dart';
import 'package:focuslab/finance/widget/cost_instance.dart';
import 'package:focuslab/finance/widget/date_range_label.dart';
import 'package:focuslab/finance/widget/finance_goal.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FinanceCubit(financeRepository: context.read<FinanceRepository>()),
      child: const FinanceView(),
    );
  }
}

class FinanceView extends StatelessWidget {
  const FinanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        action: DateRangeLabel(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.large,
            horizontal: AppSpacing.large,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ...context.watch<FinanceCubit>().state.goals.map((goal) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.medium),
                  child: FinanceGoal(
                    category: goal.category,
                    totalAmount: goal.totalAmount,
                    spent: goal.spent,
                  ),
                )),
            SizedBox(height: AppSpacing.medium),
            Text(
              'Gastos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppSpacing.medium),
            Expanded(
              child: ListView(
                children: context
                    .watch<FinanceCubit>()
                    .state
                    .costs
                    .map((cost) => CostInstance(
                          cost: cost,
                        ))
                    .toList(),
              ),
            ),
          ]),
        ),
        title: 'Finanças');
  }
}
