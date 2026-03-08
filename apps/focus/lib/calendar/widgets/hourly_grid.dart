import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/bloc/calendar_bloc.dart';
import 'package:focus/calendar/calendar.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/calendar/widgets/hour_unit.dart';

class HourlyGrid extends StatelessWidget {
  const HourlyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final dayData = context.read<DayData>();

    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        final now = state.now;
        final isToday = _isSameDay(now, dayData.hours.first);

        return ListView.builder(
          //controller: context.read<ScrollController>(),
          physics: const _SnapScrollPhysics(
            itemExtent: CalendarSettings.hourUnitHeight,
          ),
          itemExtent: CalendarSettings.hourUnitHeight,
          itemCount: dayData.hours.length,
          itemBuilder: (context, index) {
            final hour = dayData.hours[index];
            final nowFraction =
                isToday && hour.hour == now.hour
                    ? (now.minute * 60 + now.second) / 3600.0
                    : null;
            return HourUnit(startTime: hour, nowFraction: nowFraction);
          },
        );
      },
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _SnapScrollPhysics extends ScrollPhysics {
  const _SnapScrollPhysics({required this.itemExtent, super.parent});

  final double itemExtent;

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      _SnapScrollPhysics(itemExtent: itemExtent, parent: buildParent(ancestor));

  double _snapOffset(double offset) =>
      (offset / itemExtent).round() * itemExtent;

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final sim = super.createBallisticSimulation(position, velocity);
    final target = _snapOffset(
      sim != null ? sim.x(double.infinity) : position.pixels,
    );
    final tol = toleranceFor(position);
    if ((target - position.pixels).abs() < tol.distance) return null;
    return ScrollSpringSimulation(
      SpringDescription.withDampingRatio(mass: 0.1, stiffness: 1000, ratio: 2),
      position.pixels,
      target,
      velocity,
      tolerance: tol,
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}
