import 'package:app_ui/app_ui.dart';
import 'package:finance_repository/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/finance/cubit/finance_cubit.dart';
import 'package:focuslab/finance/view/categories_mapper.dart';

class CostInstance extends StatelessWidget {
  const CostInstance({super.key, required this.cost});

  final Cost cost;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dismissible(
      key: Key(cost.id.toString()),
      onDismissed: (direction) {
        context.read<FinanceCubit>().removeCost(cost);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${CategoriesMapper().emojiByCategory(cost.category)}'),
            SizedBox(width: AppSpacing.small),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cost.amount.formatAsMoney()),
                Text(
                    '${CategoriesMapper().labelByCategory(cost.category)} às ${cost.date.formatAsTime()}',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.captionColor,
                    )),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                cost.date.formatAsSimpleDate(),
              ),
              Text(
                cost.date.dayOfWeek(),
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.captionColor,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
