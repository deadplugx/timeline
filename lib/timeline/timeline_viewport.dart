class TimelineViewport {
  const TimelineViewport._({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  // доля ширины 80% - 0.8
  static const double dayFraction = 0.8;

  factory TimelineViewport.forDay(DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = DateTime(date.year, date.month, date.day + 1);

    final dayDuration = dayEnd.difference(dayStart);

    final sideDuration = Duration(
      microseconds: (dayDuration.inMicroseconds * (1 / dayFraction - 1) / 2)
          .round(),
    );

    return TimelineViewport._(
      start: dayStart.subtract(sideDuration),
      end: dayEnd.add(sideDuration),
    );
  }

  Duration get duration => end.difference(start);

  DateTime get center => start.add(duration ~/ 2);

  DateTime get focusedDay {
    final date = center;
    return DateTime(date.year, date.month, date.day);
  }

  // time > coordinate | xFor метод где рисовать заданное время
  double xFor(DateTime time, double width) {
    assert(width > 0);

    return time.difference(start).inMicroseconds /
        duration.inMicroseconds *
        width;
  }

  // coordinate > time
  DateTime timeAt(double x, double width) {
    assert(width > 0);

    return start.add(
      Duration(microseconds: (x / width * duration.inMicroseconds).round()),
    );
  }

  // перемещение на новый видимый промежуток
  // pan - панорамирование, timeAt = какое время в заданном месте
  TimelineViewport pan(double deltaX, double width) {
    final offset = timeAt(deltaX, width).difference(start);

    return TimelineViewport._(
      start: start.subtract(offset),
      end: end.subtract(offset),
    );
  }
}
