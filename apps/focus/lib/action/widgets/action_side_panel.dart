import 'package:flutter/material.dart';
import 'package:focus/action/bloc/action_bloc.dart';
import 'package:focus/action/widgets/action_duration_picker.dart';
import 'package:focus/action/widgets/action_fixed_toggle.dart';

/// Width of the side-controls panel when fully revealed.
const double kActionSidePanelWidth = 200;

/// {@template action_side_panel}
/// The controls panel that slides in to the right of the text field.
///
/// Uses [AnimatedContainer] to animate its width from `0` to
/// [kActionSidePanelWidth], while [OverflowBox] + [ClipRect] allow the content
/// to be rendered at full width and progressively revealed — so the text field
/// width stays constant throughout the animation.
/// {@endtemplate}
class ActionSidePanel extends StatelessWidget {
  /// {@macro action_side_panel}
  const ActionSidePanel({
    required this.isExpanded,
    required this.state,
    super.key,
  });

  /// Whether the panel is currently expanded (visible).
  final bool isExpanded;

  /// Current action state, used to render controls.
  final ActionState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isExpanded ? kActionSidePanelWidth : 0,
      child: ClipRect(
        child: OverflowBox(
          minWidth: 0,
          maxWidth: kActionSidePanelWidth,
          alignment: Alignment.centerLeft,
          child: IgnorePointer(
            ignoring: !isExpanded,
            child: SizedBox(
              width: kActionSidePanelWidth,
              child: Row(
                children: [
                  Container(
                    width: 0.5,
                    color: const Color.fromARGB(71, 255, 255, 255),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ActionDurationPicker(duration: state.duration),
                          const SizedBox(height: 6),
                          ActionFixedToggle(isFixed: state.isFixed),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
