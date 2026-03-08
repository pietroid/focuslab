import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:focus/calendar/calendar.dart';
import 'package:focus/calendar/widgets/hourly_grid.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';

class DayColumn extends StatefulWidget {
  const DayColumn({required this.data, required this.scrollGroup, super.key});

  /// The data for the widget.
  final DayData data;

  /// The shared scroll group for syncing all day columns.
  final LinkedScrollControllerGroup scrollGroup;

  @override
  State<DayColumn> createState() => _DayColumnState();
}

class _DayColumnState extends State<DayColumn> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollGroup.addAndGet();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        Provider<DayData>.value(value: widget.data),
        ListenableProvider<ScrollController>.value(value: scrollController),
      ],
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.data.name, style: textTheme.headlineMedium),
            Text(widget.data.dayOfTheMonth, style: textTheme.headlineSmall),
            SizedBox(height: AppSpacing.lg),
            const Expanded(child: HourlyGrid()),
          ],
        ),
      ),
    );
  }
}
