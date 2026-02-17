import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';
import 'package:focuslab/dashboard/models/grid_configuration.dart';
import 'package:focuslab/dashboard/models/time_length.dart';
import 'package:focuslab/dashboard/utils/time_grid_builder.dart';
import 'package:focuslab/dashboard/widgets/dashboard_header.dart';
import 'package:focuslab/dashboard/widgets/focus_center.dart';
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
              TimeLength.tenSeconds: const Color.fromARGB(255, 38, 255, 85),
              TimeLength.oneMinute: const Color.fromARGB(255, 255, 255, 255),
              TimeLength.fiveMinutes: const Color.fromARGB(255, 83, 238, 255),
              TimeLength.fifteenMinutes:
                  const Color.fromARGB(255, 60, 177, 255),
              TimeLength.oneHour: const Color.fromARGB(255, 255, 255, 255),
            },
            lineWidthForTimeLength: {
              TimeLength.tenSeconds: 2.0,
              TimeLength.oneMinute: 3.0,
              TimeLength.fiveMinutes: 3.0,
              TimeLength.fifteenMinutes: 5.0,
              TimeLength.oneHour: 5.0,
            },
            fadeOutTimeForTimeLength: {
              TimeLength.tenSeconds: 30 * 1000,
              TimeLength.oneMinute: 100 * 1000,
              TimeLength.fiveMinutes: 200 * 1000,
              TimeLength.fifteenMinutes: 1200 * 1000,
              TimeLength.oneHour: 3000 * 1000,
            },
            maxRadius: maxRadius,
            inflectionPoint: 60 * 1000 * 1.0,
            base: 60 * 1000 * 0.0008,
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
