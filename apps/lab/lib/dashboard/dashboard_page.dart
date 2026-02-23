import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';
import 'package:focuslab/dashboard/models/grid_configuration.dart';
import 'package:focuslab/dashboard/models/time_length.dart';
import 'package:focuslab/dashboard/utils/time_grid_builder.dart';
import 'package:focuslab/dashboard/widgets/dashboard_header.dart';
import 'package:focuslab/dashboard/widgets/focus_center.dart';
import 'package:focuslab/dashboard/widgets/focus_grid.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final maxRadius = MediaQuery.of(context).size.width / 2;

    return MultiProvider(
      providers: [
        Provider<GridConfiguration>(
          create: (_) => GridConfiguration(
            timeLengthsToRender: [
              TimeLength.tenSeconds,
              TimeLength.oneMinute,
              TimeLength.fiveMinutes,
              TimeLength.fifteenMinutes,
              TimeLength.oneHour,
            ],
            lineColorForTimeLength: {
              TimeLength.tenSeconds: const Color.fromARGB(83, 17, 255, 69),
              TimeLength.oneMinute: const Color.fromARGB(157, 103, 255, 192),
              TimeLength.fiveMinutes: const Color.fromARGB(255, 96, 255, 231),
              TimeLength.fifteenMinutes:
                  const Color.fromARGB(255, 201, 233, 255),
              TimeLength.oneHour: const Color.fromARGB(255, 255, 255, 255),
            },
            lineWidthForTimeLength: {
              TimeLength.tenSeconds: 1.0,
              TimeLength.oneMinute: 2.0,
              TimeLength.fiveMinutes: 4.0,
              TimeLength.fifteenMinutes: 8.0,
              TimeLength.oneHour: 16.0,
            },
            fadeOutTimeForTimeLength: {
              TimeLength.tenSeconds: 200 * 1000,
              TimeLength.oneMinute: 200 * 1000,
              TimeLength.fiveMinutes: 800 * 1000,
              TimeLength.fifteenMinutes: 1200 * 1000,
              TimeLength.oneHour: 3000 * 1000,
            },
            maxRadius: maxRadius * 2,
            inflectionPoint: 60 * 1000 * 2.0,
            base: 60 * 1000 * 0.0002,
            coreRadius: 100,
          ),
        ),
        BlocProvider(
          create: (context) => TimeBloc(
            configuration: context.read<GridConfiguration>(),
            builder: TimeGridBuilder(
              gridConfiguration: context.read<GridConfiguration>(),
            ),
            tickerProvider: this,
          ),
        ),
      ],
      child: const DefaultScaffold(
        body: Stack(
          children: [
            FocusCenter(),
            DashboardHeader(),
          ],
        ),
      ),
    );
  }
}
