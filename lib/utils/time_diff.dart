import 'package:intl/intl.dart';

class TimeDiff {
  final String time;

  TimeDiff(this.time);

  int diff() {
    final diff = DateTime.now().difference(DateTime.parse(time)).inDays;
    return diff;
  }
}
