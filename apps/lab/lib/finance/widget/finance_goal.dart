import 'package:app_ui/app_ui.dart';
import 'package:finance_repository/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/finance/view/categories_mapper.dart';
import 'package:focuslab/finance/widget/add_button.dart';
import 'package:focuslab/finance/widget/add_cost_popup_content.dart';

class FinanceGoal extends StatelessWidget {
  const FinanceGoal({
    required this.category,
    required this.totalAmount,
    super.key,
    this.spent = 0.0,
  });

  final CostCategory category;
  final double totalAmount;
  final double spent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${CategoriesMapper().emojiByCategory(category)} ${CategoriesMapper().labelByCategory(category)} (${totalAmount.formatAsMoney()})',
            ),
            AddButton(
              onPressed: () {
                PopupPage.show(
                  context: context,
                  content: AddCostPopupContent(category: category),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.extraSmall),
        ProgressBar(
          progress: spent,
          maxValue: totalAmount,
        ),
        const SizedBox(height: AppSpacing.extraSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gasto ${spent.formatAsMoney()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.captionColor,
                  ),
            ),
            Text(
              'Resta ${(totalAmount - spent).formatAsMoney()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.captionColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
