class TimeDiff {

  // Zamanlar arası farkı bulmayı sağlayan classımız

  final String time;
  TimeDiff(this.time);

  int diff() {
    final diff = DateTime.now().difference(DateTime.parse(time)).inDays;
    return diff;
  }
}
