import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSelectorPopup extends StatelessWidget {
  const TimeSelectorPopup({super.key});

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
        Text('Selecione um horário',
            style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: AppSpacing.medium),
        SizedBox(
          height: 150,
          child: CupertinoDatePicker(
              minimumDate: nextDateTimeDivisibleByFiveMinutes(),
              initialDateTime: nextDateTimeDivisibleByFiveMinutes(),
              minuteInterval: 5,
              use24hFormat: true,
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (DateTime newDateTime) {
                // Handle date/time changes
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
