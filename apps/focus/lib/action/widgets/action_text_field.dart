import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/action/bloc/action_bloc.dart';

/// {@template action_text_field}
/// The primary text input inside the action bar.
///
/// Dispatches [ActionTextChanged] on every keystroke and calls [onSubmit]
/// when the user confirms their input via the keyboard action button.
/// {@endtemplate}
class ActionTextField extends StatelessWidget {
  /// {@macro action_text_field}
  const ActionTextField({
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    super.key,
  });

  /// Controller that owns the current text value.
  final TextEditingController controller;

  /// Focus node used to detect when the field gains or loses focus.
  final FocusNode focusNode;

  /// Called when the user submits the text field (keyboard done action).
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.white,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: 'O que você quer fazer?',
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color.fromARGB(179, 255, 255, 255),
          fontSize: 15,
        ),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      // Prevent Flutter from auto-unfocusing when the user taps the side
      // panel — the enclosing TapRegion in ActionView handles that instead.
      onTapOutside: (_) {},
      onChanged: (text) =>
          context.read<ActionBloc>().add(ActionTextChanged(text: text)),
      onSubmitted: (_) => onSubmit(),
    );
  }
}
