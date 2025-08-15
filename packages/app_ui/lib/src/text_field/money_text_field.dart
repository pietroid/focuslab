import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class MoneyTextField extends StatelessWidget {
  final TextEditingController controller;

  MoneyTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        CurrencyTextInputFormatter.currency(
          symbol: '',
        ),
      ],
    );
  }
}
