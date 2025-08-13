import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/finance/widget/add_button.dart';

class FinanceGoal extends StatelessWidget {
  const FinanceGoal({
    super.key,
    required this.title,
    required this.totalAmount,
    this.spent = 0.0,
  });

  final String title;
  final double totalAmount;
  final double spent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$title (R\$ $totalAmount)'),
            AddButton(),
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        Container(
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.defaultCardColor,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: (spent / totalAmount * 100).toInt(),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 195, 81, 81),
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  ),
                ),
              ),
              Expanded(
                flex: 100 - (spent / totalAmount * 100).toInt(),
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Gasto R\$ $spent',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.captionColor,
                    )),
            Text('Resta R\$ ${totalAmount - spent}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.captionColor,
                    )),
          ],
        ),
      ],
    );
  }
}
