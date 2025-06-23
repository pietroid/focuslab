import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Item extends StatelessWidget {
  const Item({
    required this.text,
    required this.date,
    super.key,
  });

  final String text;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     const Color.fromARGB(255, 4, 4, 4).withOpacity(0.6),
        //     const Color.fromARGB(255, 4, 4, 4).withOpacity(0.6),
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        //color: AppColors.primaryColor.withOpacity(0.01),
        borderRadius: BorderRadius.circular(AppSpacing.xxsmall),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xxxsmall, horizontal: AppSpacing.xxsmall),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${date.formatAsSimpleDate()}',
                style: Theme.of(context).textTheme.headlineSmall),
            Text(date.dayOfWeek().capitalize(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryColor.withOpacity(0.7),
                    )),
          ],
        ),
        Expanded(
          child: const SizedBox.shrink(),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryColor.withOpacity(0.7),
              ),
        ),
      ]),
    );
  }
}
