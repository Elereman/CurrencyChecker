class TimeGap {
  final DateTime from;
  final DateTime to;

  TimeGap(this.from, this.to) : assert(from.isBefore(to));
}
