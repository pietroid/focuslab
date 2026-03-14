/// Extension on [DateTime] to provide custom formatting for calendar display.
extension CalendarFormatter on DateTime {
  /// Formats the [DateTime] instance into a string with the format "dd/MM".
  String dayOfTheMonth() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';
  }
}
