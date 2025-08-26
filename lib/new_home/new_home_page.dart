import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/finance/widget/add_button.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultScaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.medium, horizontal: AppSpacing.large),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '11:04',
              style: textTheme.displayMedium?.copyWith(),
            ),
            Text(
              'Terça-feira, 26 de agosto',
            ),
            SizedBox(height: AppSpacing.large),
            DefaultCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Codando focuslab'),
                      AddButton(),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  ProgressBar(progress: 35, maxValue: 100),
                  SizedBox(height: AppSpacing.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('10:00 - 13:00'),
                      Text('Faltam 1:55'),
                    ],
                  )
                ])),
            SizedBox(height: AppSpacing.small),
          ],
        ),
      ]),
    ));
  }
}
