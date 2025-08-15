import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCostPopupContent extends StatelessWidget {
  const AddCostPopupContent({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Adicionar custo para $category',
            style: TextTheme.of(context).titleMedium),
        SizedBox(height: AppSpacing.large),
        Text('Valor:'),
        SizedBox(width: 10),
        MoneyTextField(),
        SizedBox(height: AppSpacing.large),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}
