import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';
import 'package:focuslab/dashboard/widgets/dashboard_header.dart';
import 'package:focuslab/dashboard/widgets/focus_center.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimeBloc(),
      child: const DefaultScaffold(
          body: Stack(
        children: [
          FocusCenter(),
          DashboardHeader(),
        ],
      )),
    );
  }
}
