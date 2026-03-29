import 'package:flutter/material.dart';
import 'package:focus/action/bloc/action_bloc.dart';
import 'package:focus/action/widgets/action_side_panel.dart';
import 'package:focus/action/widgets/action_text_field.dart';

const double _kCollapsedWidth = 300;
const double _kExpandedWidth = _kCollapsedWidth + kActionSidePanelWidth;
const double _kHeight = 50;

/// {@template action_input_pill}
/// The pill-shaped quick-add bar at the bottom of the screen.
///
/// Renders an [ActionTextField] for entering a task name. When focused,
/// the pill expands horizontally via [AnimatedContainer] to reveal
/// [ActionSidePanel] on the right with scheduling controls.
///
/// This widget is purely presentational — it does not own the
/// [controller] or [focusNode], and emits user interactions through
/// [onSubmit]. The caller is responsible for wrapping this widget in a
/// [TapRegion] if outside-tap-to-unfocus behavior is needed.
/// {@endtemplate}
class ActionInputPill extends StatelessWidget {
  /// {@macro action_input_pill}
  const ActionInputPill({
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    required this.state,
    super.key,
  });

  /// Controller for the task-name text field.
  final TextEditingController controller;

  /// Focus node for the task-name text field.
  final FocusNode focusNode;

  /// Called when the user submits the text field.
  final VoidCallback onSubmit;

  /// Current [ActionState], used to drive the expand animation and the
  /// scheduling controls inside [ActionSidePanel].
  final ActionState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _kHeight,
      width: state.isExpanded ? _kExpandedWidth : _kCollapsedWidth,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 29, 52),
        borderRadius: BorderRadius.all(Radius.circular(24)),
        border: Border.fromBorderSide(
          BorderSide(
            color: Color.fromARGB(71, 255, 255, 255),
            width: 0.5,
          ),
        ),
        boxShadow: [BoxShadow(blurRadius: 20, spreadRadius: 5)],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Row(
          children: [
            Expanded(
              child: ActionTextField(
                controller: controller,
                focusNode: focusNode,
                onSubmit: onSubmit,
              ),
            ),
            ActionSidePanel(
              isExpanded: state.isExpanded,
              state: state,
            ),
          ],
        ),
      ),
    );
  }
}
