import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class MoneyTextField extends StatelessWidget {
  const MoneyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        CurrencyTextInputFormatter.currency(
          symbol: '',
        ),
      ],
    );
  }
}
