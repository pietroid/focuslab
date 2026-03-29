import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/action/bloc/action_bloc.dart';
import 'package:focus/action/widgets/action_side_panel.dart';
import 'package:focus/action/widgets/action_text_field.dart';
import 'package:focus/events/bloc/events_bloc.dart';

// ---------------------------------------------------------------------------
// Pill dimensions
// ---------------------------------------------------------------------------

/// Width of the pill when idle (no text entered).
const double _kCollapsedWidth = 300;

/// Total width of the pill when expanded.
const double _kExpandedWidth = _kCollapsedWidth + kActionSidePanelWidth;

/// Fixed height of the pill — never changes so vertical overflow cannot occur.
const double _kHeight = 50;

// ---------------------------------------------------------------------------
// Widgets
// ---------------------------------------------------------------------------

/// {@template action_view}
/// Entrypoint for the quick-add action of the Focus app.
///
/// Renders a floating pill anchored to the bottom of the screen. When the
/// text field is focused the pill expands **horizontally**, sliding a compact
/// panel of scheduling controls in from the right — keeping everything in a
/// single row and avoiding any vertical overflow.
/// {@endtemplate}
class ActionView extends StatelessWidget {
  /// {@macro action_view}
  const ActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActionBloc(),
      child: const _ActionContent(),
    );
  }
}

class _ActionContent extends StatefulWidget {
  const _ActionContent();

  @override
  State<_ActionContent> createState() => _ActionContentState();
}

class _ActionContentState extends State<_ActionContent> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      context.read<ActionBloc>().add(ActionFocused());
    } else {
      context.read<ActionBloc>().add(ActionUnfocused());
    }
  }

  void _onSubmit() {
    final actionState = context.read<ActionBloc>().state;
    final text = actionState.text.trim();
    if (text.isEmpty) return;

    context.read<EventsBloc>().add(
      EventAddedQuickly(
        name: text,
        durationMinutes: actionState.duration.minutes,
        isFixed: actionState.isFixed,
      ),
    );

    context.read<ActionBloc>().add(ActionSubmitted());
    _controller.clear();
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<ActionBloc, ActionState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            // Push the pill above the software keyboard when it appears.
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
            child: TapRegion(
              // Taps outside the pill unfocus the text field; taps on the
              // side panel chips stay within the region and do not unfocus.
              onTapOutside: (_) => _focusNode.unfocus(),
              child: AnimatedContainer(
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
                  boxShadow: [
                    BoxShadow(blurRadius: 20, spreadRadius: 5),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: Row(
                    children: [
                      Expanded(
                        child: ActionTextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          onSubmit: _onSubmit,
                        ),
                      ),
                      ActionSidePanel(
                        isExpanded: state.isExpanded,
                        state: state,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
