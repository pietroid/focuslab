import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/calendar.dart';
import 'package:focus/calendar/widgets/hour_unit.dart';
import 'package:provider/provider.dart';

const _itemExtent = 52.0;

class HourlyGrid extends StatelessWidget {
  const HourlyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final dayData = context.read<DayData>();

    return ListView.builder(
      controller: context.read<ScrollController>(),
      physics: const _SnapScrollPhysics(itemExtent: _itemExtent),
      itemExtent: _itemExtent,
      itemCount: dayData.hours.length,
      itemBuilder:
          (context, index) => HourUnit(startTime: dayData.hours[index]),
    );
  }
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
