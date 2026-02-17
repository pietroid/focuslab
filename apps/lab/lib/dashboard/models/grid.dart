import 'package:focuslab/dashboard/models/grid_configuration.dart';
import 'package:focuslab/dashboard/models/time_length.dart';

class Grid {
  Grid({
    required this.configuration,
    required this.gridRadiusesPerTimeLength,
  });

  GridConfiguration configuration;

  Map<TimeLength, List<double>> gridRadiusesPerTimeLength;
}
