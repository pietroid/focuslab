/// {@template app_spacing}
/// Default spacings to be used accross the App.
/// {@endtemplate}
class AppSpacing {
  /// The base unit for spacing calculations.
  static int unit = 8;

  /// Extra small spacing (4px)
  static double get xs => unit * 0.5;

  /// Small spacing (8px)
  static double get sm => unit * 1;

  /// Medium spacing (16px)
  static double get md => unit * 2;

  /// Large spacing (24px)
  static double get lg => unit * 3;
}
