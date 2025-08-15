import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/finance/cubit/finance_cubit.dart';
import 'package:focuslab/finance/widget/change_date_range_popup_content.dart';

class DateRangeLabel extends StatelessWidget {
  const DateRangeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FinanceCubit>().state;
    final daysDifference = state.endDate.difference(state.startDate).inDays;
    return GestureDetector(
      onTap: () {
        PopupPage.show(
          context: context,
          content: BlocProvider.value(
              value: context.read<FinanceCubit>(),
              child: ChangeDateRangePopupContent()),
        );
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
                '${state.startDate.formatAsSimpleDate()} - ${state.endDate.formatAsSimpleDate()}'),
            Text('${daysDifference} dias',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.captionColor,
                    )),
          ]),
    );
  }
}
