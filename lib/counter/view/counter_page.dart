import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/counter/counter.dart';
import 'package:focuslab/counter/widgets/item.dart';
import 'package:focuslab/l10n/l10n.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterView(),
    );
  }
}

List<DateTime> generateDates(DateTime startDate, int count) {
  return List.generate(count, (index) {
    return startDate.add(Duration(days: index));
  });
}

class CounterView extends StatelessWidget {
  CounterView({super.key});

  final _allDates = generateDates(
    DateTime(2025, 7, 14),
    7,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Row(children: [
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Viagem do Pará',
                  style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: AppSpacing.xxsmall),
              Text(
                'Primeira semana',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: AppColors.primaryColor),
              ),
              const SizedBox(height: AppSpacing.small),
              ..._allDates.map(
                (date) => V([
                  Item(
                    text: 'Primeiro dia',
                    date: date,
                  ),
                  _allDates.last == date
                      ? const SizedBox.shrink()
                      : const Spacer(),
                ]),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.medium),
        Flexible(
          flex: 1,
          child: Container(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ]),
    ));
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}

class Spacer extends StatelessWidget {
  const Spacer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
      width: double.infinity,
      height: 2,
    );
  }
}

class V extends StatelessWidget {
  const V(
    this.children, {
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
