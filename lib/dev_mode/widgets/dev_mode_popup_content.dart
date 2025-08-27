import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DevModePopupContent extends StatelessWidget {
  final bool timeConstrainedNowTask;
  final ValueChanged<bool> onTimeConstrainedNowTaskChanged;

  const DevModePopupContent({
    super.key,
    required this.timeConstrainedNowTask,
    required this.onTimeConstrainedNowTaskChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Dev Mode'),
        Row(children: [
          Checkbox(
              value: timeConstrainedNowTask,
              onChanged: (value) {
                context.pop();
                if (value != null) {
                  onTimeConstrainedNowTaskChanged(value);
                }
              }),
          Text('Time constrained now task'),
        ]),
      ],
    );
  }
}
