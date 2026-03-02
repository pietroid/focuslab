import 'dart:ui';

import 'package:focuslab/dashboard/models/time_length.dart';

class GridConfiguration {
  GridConfiguration({
    required this.timeLengthsToRender,
    required this.lineColorForTimeLength,
    required this.lineWidthForTimeLength,
    required this.fadeOutTimeForTimeLength,
    required this.inflectionPoint,
    required this.maxRadius,
    required this.coreRadius,
    required this.base,
  });

  /// Time lengths to be rendered on the grid.
  List<TimeLength> timeLengthsToRender;

  /// Color to be used for the line corresponding to each time length.
  Map<TimeLength, Color> lineColorForTimeLength;

  /// Width to be used for the line corresponding to each time length.
  Map<TimeLength, double> lineWidthForTimeLength;

  /// Decay time is time in milliseconds from the center
  /// to the point where the line corresponding to a time length
  /// should be completely faded out.
  Map<TimeLength, int> fadeOutTimeForTimeLength;

  /// Time in milliseconds from the center to the point where the wave starts
  /// to grow faster.
  double inflectionPoint;

  /// Maximum radius of the grid, which corresponds to half of the screen width,
  /// in pixels.
  double maxRadius;

  /// Radius of the core used to show the clock, in pixels.
  double coreRadius;

  /// Base of the logarithm used to calculate the radius of the waves, in ms.
  double base;
}
