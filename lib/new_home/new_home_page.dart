import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/dev_mode/widgets/dev_mode_popup_content.dart';
import 'package:focuslab/finance/widget/add_button.dart';
import 'package:focuslab/new_home/widgets/analog_clock.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  bool timeConstrainedNowTask = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultScaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.medium, horizontal: AppSpacing.large),
      child: Stack(
        children: [
          Column(
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
                                '19:41',
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
                              Text('19:00 - 21:00'),
                              Text('Faltam 1:20'),
                            ],
                          )
                        ])),
                    SizedBox(height: AppSpacing.large),
                    Text('Ainda hoje', style: textTheme.titleLarge),
                    SizedBox(height: AppSpacing.small),
                    DefaultCard(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lavar louça'),
                        Text('21:00 - 21:15', style: textTheme.bodySmall),
                      ],
                    )),
                    SizedBox(height: AppSpacing.extraSmall),
                    DefaultCard(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Preparar para dormir'),
                        Text('21:30', style: textTheme.bodySmall),
                      ],
                    )),
                  ],
                ),
              ]),
          Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  PopupPage.show(
                      context: context,
                      content: DevModePopupContent(
                        timeConstrainedNowTask: timeConstrainedNowTask,
                        onTimeConstrainedNowTaskChanged: (value) {
                          setState(() {
                            timeConstrainedNowTask = value;
                          });
                        },
                      ));
                },
                child: const Icon(Icons.add),
              )),
        ],
      ),
    ));
  }
}
