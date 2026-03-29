part of 'action_bloc.dart';

enum ActionDuration { min15, min30, min45, min60 }

extension ActionDurationExtension on ActionDuration {
  int get minutes => const [15, 30, 45, 60][index];

  String get label => const ['15m', '30m', '45m', '1h'][index];
}

class ActionState {
  const ActionState({
    this.isExpanded = false,
    this.text = '',
    this.duration = ActionDuration.min30,
    this.isFixed = false,
  });

  final bool isExpanded;
  final String text;
  final ActionDuration duration;
  final bool isFixed;

  ActionState copyWith({
    bool? isExpanded,
    String? text,
    ActionDuration? duration,
    bool? isFixed,
  }) =>
      ActionState(
        isExpanded: isExpanded ?? this.isExpanded,
        text: text ?? this.text,
        duration: duration ?? this.duration,
        isFixed: isFixed ?? this.isFixed,
      );
}
