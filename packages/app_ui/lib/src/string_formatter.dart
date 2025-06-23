import 'package:intl/intl.dart';

extension StringFormatter on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension MoneyFormatter on double {
  String formatAsMoney() {
    final formatter = NumberFormat.decimalPatternDigits(
      locale: 'pt_BR',
      decimalDigits: 2,
    );
    final formattedNumber = formatter.format(this);
    return '\$ $formattedNumber';
  }
}

extension MoneyFormatterText on String {
  num formatAsNumber() {
    final formatter = NumberFormat.decimalPatternDigits(
      locale: 'pt_BR',
      decimalDigits: 2,
    );
    final parsedNumber = formatter.parse(this);
    return parsedNumber;
  }
}

extension DateTimeFormatter on DateTime {
  String formatAsSimpleDate() {
    final formatter = DateFormat('dd/MM');
    return formatter.format(this);
  }

  String formatAsFullDate() {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this);
  }

  String formatAsTime() {
    final formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }

  String formatAsDateTime() {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(this);
  }

  String dayOfWeek() {
    final formatter = DateFormat('EEEE', 'pt_BR');
    return formatter.format(this);
  }
}
