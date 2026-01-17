import 'package:app_ui/app_ui.dart';
import 'package:finance_repository/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/finance/view/categories_mapper.dart';
import 'package:go_router/go_router.dart';

class AddCostPopupContent extends StatefulWidget {
  const AddCostPopupContent({super.key, required this.category});

  final CostCategory category;

  @override
  State<AddCostPopupContent> createState() => _AddCostPopupContentState();
}

class _AddCostPopupContentState extends State<AddCostPopupContent> {
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            'Adicionar custo para ${CategoriesMapper().labelByCategory(widget.category)}',
            style: TextTheme.of(context).titleMedium),
        SizedBox(height: AppSpacing.large),
        Text('Valor:'),
        SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: MoneyTextField(
            controller: _amountController,
          ),
        ),
        SizedBox(height: AppSpacing.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                final cost =
                    Cost(amount: double.tryParse(_amountController.text) ?? 0);

                cost.category = widget.category;

                context.read<FinanceRepository>().addCost(cost);
                context.pop();
              },
              child: Text('Salvar'),
            ),
            SizedBox(width: AppSpacing.large),
            MaterialButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        ),
      ],
    );
  }
}
