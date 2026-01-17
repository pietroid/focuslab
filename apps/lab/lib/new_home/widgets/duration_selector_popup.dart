import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DurationSelectorPopup extends StatelessWidget {
  const DurationSelectorPopup({super.key});

  DateTime nextDateTimeDivisibleByFiveMinutes() {
    final now = DateTime.now();
    final minutes = now.minute;
    final remainder = minutes % 5;
    if (remainder == 0) {
      return now;
    }
    return now.add(Duration(minutes: 5 - remainder));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Selecione um duração',
            style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: AppSpacing.medium),
        SizedBox(
          height: 150,
          child: CupertinoTimerPicker(
              minuteInterval: 5,
              mode: CupertinoTimerPickerMode.hm,
              onTimerDurationChanged: (Duration newDuration) {
                // Handle duration changes
              }),
        ),
        SizedBox(height: AppSpacing.medium),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              label: 'Cancelar',
              destructive: true,
            ),
            SizedBox(width: AppSpacing.extraSmall),
            Button(
              label: 'Confirmar',
            ),
          ],
        ),
      ],
    );
  }
}
