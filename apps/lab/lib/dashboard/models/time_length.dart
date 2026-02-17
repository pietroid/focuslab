/// Time length convention to be used on the time grid.
enum TimeLength {
  oneSecond(1000),
  fiveSeconds(5 * 1000),
  tenSeconds(10 * 1000),
  oneMinute(60 * 1000),
  fiveMinutes(5 * 60 * 1000),
  tenMinutes(10 * 60 * 1000),
  fifteenMinutes(15 * 60 * 1000),
  thirtyMinutes(30 * 60 * 1000),
  oneHour(60 * 60 * 1000);

  final int milliseconds;

  const TimeLength(this.milliseconds);
}
