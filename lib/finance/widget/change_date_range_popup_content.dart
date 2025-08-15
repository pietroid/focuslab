import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/finance/cubit/finance_cubit.dart';

class ChangeDateRangePopupContent extends StatefulWidget {
  const ChangeDateRangePopupContent({super.key});

  @override
  State<ChangeDateRangePopupContent> createState() =>
      _ChangeDateRangePopupContentState();
}

class _ChangeDateRangePopupContentState
    extends State<ChangeDateRangePopupContent> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    startDate = context.read<FinanceCubit>().state.startDate;
    endDate = context.read<FinanceCubit>().state.endDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Data inicial'),
                ElevatedButton(
                    onPressed: () async {
                      final newStartDate = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (newStartDate != null) {
                        setState(() {
                          startDate = newStartDate;
                        });
                      }
                    },
                    child: Text(startDate.formatAsSimpleDate())),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Data final'),
                ElevatedButton(
                  onPressed: () async {
                    final newEndDate = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (newEndDate != null) {
                      setState(() {
                        endDate = newEndDate;
                      });
                    }
                  },
                  child: Text(endDate.formatAsSimpleDate()),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.read<FinanceCubit>().updateDateRange(startDate, endDate);
            Navigator.of(context).pop();
          },
          child: const Text('Aplicar'),
        ),
      ],
    );
  }
}
