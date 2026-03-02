import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';

class Clock extends StatelessWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.headlineMedium?.copyWith(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontWeight: FontWeight.w200,
      fontSize: 50,
    );
    return BlocBuilder<TimeBloc, TimeState>(
      builder: (context, state) {
        final now = state.now;
        final formattedTime =
            '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
        return Text(
          formattedTime,
          style: textStyle,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
