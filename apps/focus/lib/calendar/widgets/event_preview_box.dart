import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/bloc/event_preview_bloc.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';

class EventPreviewBox extends StatefulWidget {
  const EventPreviewBox({
    required this.startTime,
    required this.endTime,
    required this.scrollOffset,
    super.key,
  });

  final DateTime startTime;
  final DateTime endTime;
  final double scrollOffset;

  @override
  State<EventPreviewBox> createState() => _EventPreviewBoxState();
}

class _EventPreviewBoxState extends State<EventPreviewBox> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    final initialName = context.read<EventPreviewBloc>().state.name;
    _controller = TextEditingController(text: initialName);
    _focusNode = FocusNode()..addListener(_onFocusChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && !_submitted) {
      context.read<EventPreviewBloc>().add(const PreviewCancelled());
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startFraction =
        widget.startTime.hour + widget.startTime.minute / 60.0;
    final endFraction = widget.endTime.hour + widget.endTime.minute / 60.0;
    final top =
        startFraction * CalendarSettings.hourUnitHeight - widget.scrollOffset;
    final height =
        (endFraction - startFraction) * CalendarSettings.hourUnitHeight;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: height.clamp(30.0, double.infinity),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0x9950E8FF),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(4),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          decoration: const InputDecoration.collapsed(hintText: 'Event name'),
          onChanged:
              (value) => context.read<EventPreviewBloc>().add(
                PreviewNameChanged(name: value),
              ),
          onSubmitted: (_) {
            _submitted = true;
            context.read<EventPreviewBloc>().add(const PreviewConfirmed());
          },
        ),
      ),
    );
  }
}
