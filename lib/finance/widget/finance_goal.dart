import 'package:app_ui/app_ui.dart';
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
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$title (R\$ $totalAmount)'),
              AddButton(),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          Container(
            height: 8,
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
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.cardRadius),
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
          const SizedBox(height: AppSpacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gasto R\$ $spent'),
              Text('Resta R\$ ${totalAmount - spent}'),
            ],
          ),
        ],
      ),
    );
  }
}
