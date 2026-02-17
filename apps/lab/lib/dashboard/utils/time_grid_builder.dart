import 'dart:math';

import 'package:focuslab/dashboard/models/grid.dart';
import 'package:focuslab/dashboard/models/grid_configuration.dart';
import 'package:focuslab/dashboard/models/time_length.dart';

class TimeGridBuilder {
  TimeGridBuilder({
    required this.gridConfiguration,
  });

  /// Configuration used for building the grid.
  final GridConfiguration gridConfiguration;

  /// Yield the next delta time based on the current time,
  /// the current delta time and the time width.
  ///
  /// Units:
  ///
  /// now (DateTime)
  /// currentDeltaTime (ms)
  /// timeWidth (ms)
  int yieldNextDeltaTime(
    DateTime now,
    int currentDeltaTime,
    TimeLength timeWidth,
  ) {
    /// Calculates the current time in milliseconds.
    final nowInMs = now.millisecondsSinceEpoch;

    /// Calculates the next point in time based on the current time and
    /// the current delta time.
    final pointInTime = nowInMs + currentDeltaTime;

    /// Calculates the time to the latest grid point based on the current point
    /// in time and the time width.
    final timeToLatestGridPoint = pointInTime % timeWidth.milliseconds;

    /// Calculates the time to the next grid point based on the time to
    /// the latest grid point and the time width.
    final timeToNextGridPoint = timeWidth.milliseconds - timeToLatestGridPoint;

    /// Calculates the next delta time based on the current delta time and
    /// the time to the next grid point.
    return currentDeltaTime + timeToNextGridPoint;
  }

  /// The main equation used to map the radius from the time difference
  /// from now.
  ///
  /// units:
  ///
  /// r (px)
  /// deltaTime (ms)
  /// inflectionPoint (ms)
  /// base of logarithm (ms)
  double r(
    int deltaTime,
    double inflectionPoint,
    double base,
  ) {
    /// Alpha constant used in the equation.
    final alpha = 1 / log(base);

    /// velocity at 0, px per ms
    final v0 = alpha / (inflectionPoint - alpha);

    return alpha * log((v0 * deltaTime) / alpha + 1);
  }

  /// Build the grid based on the current time and
  /// the time width.
  ///
  /// Units:
  ///
  /// now (DateTime)
  /// int (px)
  /// timeWidth (TimeLength)
  List<double> buildGridForTimeWidth(
    DateTime now,
    TimeLength timeWidth,
  ) {
    final grid = <double>[];

    var currentDeltaTime = 0;

    final maxRadius = gridConfiguration.maxRadius *
        r(
          gridConfiguration.fadeOutTimeForTimeLength[timeWidth]!,
          gridConfiguration.inflectionPoint,
          gridConfiguration.base,
        );

    for (var i = 0; i < 100; i++) {
      /// calculate delta time
      currentDeltaTime = yieldNextDeltaTime(now, currentDeltaTime, timeWidth);

      /// maps to radius
      final radius = r(
            currentDeltaTime,
            gridConfiguration.inflectionPoint,
            gridConfiguration.base,
          ) *
          500;

      if (radius > maxRadius) {
        break;
      }
      grid.add(radius);
    }

    return grid;
  }

  /// Build the grid based on the current time and the configuration.
  Grid buildGrid(
    DateTime now,
    GridConfiguration configuration,
  ) {
    final gridRadiusesPerTimeLength = <TimeLength, List<double>>{};

    for (final timeLength in configuration.timeLengthsToRender) {
      gridRadiusesPerTimeLength[timeLength] =
          buildGridForTimeWidth(now, timeLength);
    }

    return Grid(
      configuration: configuration,
      gridRadiusesPerTimeLength: gridRadiusesPerTimeLength,
    );
  }
}
