part of 'drag_grid_bloc.dart';

sealed class DragGridEvent {
  const DragGridEvent();
}

class DragStarted extends DragGridEvent {
  const DragStarted({required this.time});

  final DateTime time;
}

class DragUpdated extends DragGridEvent {
  const DragUpdated({required this.time});

  final DateTime time;
}

class DragEnded extends DragGridEvent {
  const DragEnded({required this.time});

  final DateTime time;
}
