import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/action/bloc/action_bloc.dart';
import 'package:focus/action/widgets/action_clock_icon.dart';

/// {@template action_duration_picker}
/// A compact row of chip buttons for selecting a task duration.
///
/// Shows an [ActionClockIcon] whose minute hand reflects the active selection,
/// followed by one small chip per [ActionDuration] value. Tapping a chip
/// dispatches [ActionDurationChanged] to the nearest [ActionBloc].
/// {@endtemplate}
class ActionDurationPicker extends StatelessWidget {
  /// {@macro action_duration_picker}
  const ActionDurationPicker({required this.duration, super.key});

  /// The currently selected duration, used to highlight the active chip and
  /// position the clock hand.
  final ActionDuration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ActionClockIcon(duration: duration),
        const SizedBox(width: 5),
        ...ActionDuration.values.map(
          (d) => _DurationChip(
            label: d.label,
            isSelected: d == duration,
            onTap: () => context
                .read<ActionBloc>()
                .add(ActionDurationChanged(duration: d)),
          ),
        ),
      ],
    );
  }
}

/// {@template _duration_chip}
/// A compact tappable chip representing a single [ActionDuration] option
/// inside [ActionDurationPicker].
/// {@endtemplate}
class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(55, 255, 255, 255)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : const Color.fromARGB(140, 255, 255, 255),
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
