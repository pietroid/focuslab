part of 'action_bloc.dart';

sealed class ActionEvent {}

final class ActionFocused extends ActionEvent {}

final class ActionUnfocused extends ActionEvent {}

final class ActionTextChanged extends ActionEvent {
  ActionTextChanged({required this.text});
  final String text;
}

final class ActionDurationChanged extends ActionEvent {
  ActionDurationChanged({required this.duration});
  final ActionDuration duration;
}

final class ActionFixedChanged extends ActionEvent {
  ActionFixedChanged({required this.isFixed});
  final bool isFixed;
}

final class ActionSubmitted extends ActionEvent {}
