import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focuslab/finance/widget/add_button.dart';
import 'package:focuslab/new_home/widgets/analog_clock.dart';
import 'package:focuslab/new_home/widgets/creation_bottom_sheet.dart';
import 'package:focuslab/new_home/widgets/home_add_buton.dart';
import 'package:go_router/go_router.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  bool timeConstrainedNowTask = false;
  bool showRecommendations = false;
  bool emptyStateToday = true;
  bool currentlyPlayingTask = false;

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
              //mainAxisSize: MainAxisSize.min,
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
                        // AnalogClock(),
                      ],
                    ),
                    SizedBox(height: AppSpacing.small),
                    if (showRecommendations)
                      SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            DefaultCard(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(53, 255, 0, 0),
                                  Color.fromARGB(39, 255, 119, 0)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '4',
                                      textAlign: TextAlign.center,
                                      style: textTheme.displaySmall?.copyWith(
                                          color: const Color.fromARGB(
                                              208, 255, 118, 20)),
                                    ),
                                    Text(
                                      'Dias sem academia',
                                      textAlign: TextAlign.center,
                                      style: textTheme.bodyLarge?.copyWith(
                                          color: const Color.fromARGB(
                                              208, 255, 184, 133)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacing.small),
                            DefaultCard(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(31, 255, 153, 0),
                                  Color.fromARGB(39, 153, 255, 0)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '3',
                                      textAlign: TextAlign.center,
                                      style: textTheme.displaySmall?.copyWith(
                                          color: const Color.fromARGB(
                                              208, 255, 201, 101)),
                                    ),
                                    Text(
                                      'Pendências',
                                      textAlign: TextAlign.center,
                                      style: textTheme.bodyLarge?.copyWith(
                                          color: const Color.fromARGB(
                                              208, 255, 220, 114)),
                                    ),
                                    Text('Resolva em 1h',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: const Color.fromARGB(
                                              137, 255, 227, 47),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacing.small),
                            DefaultCard(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(53, 0, 255, 4),
                                  Color.fromARGB(39, 0, 255, 217)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'R\$ 300',
                                      textAlign: TextAlign.center,
                                      style: textTheme.titleMedium?.copyWith(
                                          color: const Color.fromARGB(
                                              208, 20, 255, 145)),
                                    ),
                                    Text(
                                      'Para gastar',
                                      textAlign: TextAlign.center,
                                      style: textTheme.bodyLarge?.copyWith(
                                          color: const Color.fromARGB(
                                              208, 133, 255, 176)),
                                    ),
                                    Text('Até segunda',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: const Color.fromARGB(
                                              137, 47, 255, 161),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: AppSpacing.large),
                    Text('Ainda hoje', style: textTheme.titleLarge),
                    SizedBox(height: AppSpacing.small),
                    if (emptyStateToday)
                      Text('Nada planejado, clique para organizar',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.captionColor,
                          )),
                    if (!emptyStateToday) ...[
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
                      SizedBox(height: AppSpacing.large),
                    ]
                  ],
                ),
              ]),
          if (currentlyPlayingTask)
            Align(
              alignment: Alignment.bottomCenter,
              child: DefaultCard(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
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
            ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                PopupPage.show(
                    context: context,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Dev Mode'),
                        Row(children: [
                          Checkbox(
                              value: timeConstrainedNowTask,
                              onChanged: (value) {
                                context.pop();
                                if (value != null) {
                                  setState(() {
                                    timeConstrainedNowTask = value;
                                  });
                                }
                              }),
                          Text('Time constrained now task'),
                        ]),
                        Row(children: [
                          Checkbox(
                              value: showRecommendations,
                              onChanged: (value) {
                                context.pop();
                                if (value != null) {
                                  setState(() {
                                    showRecommendations = value;
                                  });
                                }
                              }),
                          Text('Show recommendations'),
                        ]),
                        Row(children: [
                          Checkbox(
                              value: emptyStateToday,
                              onChanged: (value) {
                                context.pop();
                                if (value != null) {
                                  setState(() {
                                    emptyStateToday = value;
                                  });
                                }
                              }),
                          Text('Empty state today'),
                        ]),
                        Row(children: [
                          Checkbox(
                              value: currentlyPlayingTask,
                              onChanged: (value) {
                                context.pop();
                                if (value != null) {
                                  setState(() {
                                    currentlyPlayingTask = value;
                                  });
                                }
                              }),
                          Text('Currently playing task'),
                        ]),
                      ],
                    ));
              },
              child: Icon(Icons.settings, color: Colors.white.withOpacity(0.1)),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: HomeAddButton(
              onPressed: () {
                CreationBottomSheet().show(context);
              },
            ),
          ),
        ],
      ),
    ));
  }
}
