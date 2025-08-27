import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/finance/widget/add_button.dart';
import 'package:focuslab/new_home/widgets/analog_clock.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultScaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.medium, horizontal: AppSpacing.large),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '21:34',
                            style: textTheme.displayMedium?.copyWith(),
                          ),
                          Text(
                            'Quarta-feira, 26 de agosto',
                          ),
                        ]),
                    Expanded(
                      child: Container(),
                    ),
                    AnalogClock(),
                  ],
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
                      ProgressBar(progress: 65, maxValue: 100),
                      SizedBox(height: AppSpacing.small),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('10:00 - 13:00'),
                          Text('Faltam 1:10'),
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
