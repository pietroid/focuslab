import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/action/bloc/action_bloc.dart';

/// {@template action_fixed_toggle}
/// A compact row toggle for switching between fixed and flexible scheduling.
///
/// Shows an animated lock icon next to a custom [_MiniSwitch]. Tapping
/// anywhere dispatches [ActionFixedChanged] to the nearest [ActionBloc].
/// {@endtemplate}
class ActionFixedToggle extends StatelessWidget {
  /// {@macro action_fixed_toggle}
  const ActionFixedToggle({required this.isFixed, super.key});

  /// Whether the task is currently in fixed-time mode.
  final bool isFixed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<ActionBloc>().add(ActionFixedChanged(isFixed: !isFixed)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isFixed ? Icons.lock_rounded : Icons.lock_open_rounded,
              key: ValueKey(isFixed),
              color: const Color.fromARGB(180, 255, 255, 255),
              size: 13,
            ),
          ),
          const SizedBox(width: 4),
          _MiniSwitch(value: isFixed),
          const SizedBox(width: 4),
          Text(
            isFixed ? 'Fixo' : 'Flex',
            style: const TextStyle(
              color: Color.fromARGB(160, 255, 255, 255),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template _mini_switch}
/// A hand-drawn pill toggle sized to fit within a 50 px tall row.
///
/// Animates its thumb position and track color when [value] changes.
/// {@endtemplate}
class _MiniSwitch extends StatelessWidget {
  const _MiniSwitch({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 26,
      height: 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: value
            ? const Color.fromARGB(90, 255, 255, 255)
            : const Color.fromARGB(40, 255, 255, 255),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
