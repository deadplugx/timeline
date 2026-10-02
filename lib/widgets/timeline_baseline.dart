import 'package:flutter/material.dart';

import '../timeline/timeline_viewport.dart';
import 'date_spot.dart';

class TimelineBaseline extends StatefulWidget {
  const TimelineBaseline({super.key});

  @override
  State<TimelineBaseline> createState() => _TimelineBaselineState();
}

class _TimelineBaselineState extends State<TimelineBaseline> {
  late TimelineViewport _viewport;

  @override
  void initState() {
    super.initState();

    _viewport = TimelineViewport.forDay(DateTime.now());
  }

  List<DateTime> _visibleTimes() {
    final times = <DateTime>[];

    var day = DateTime(
      _viewport.start.year,
      _viewport.start.month,
      _viewport.start.day,
    );

    while (!day.isAfter(_viewport.end)) {
      final nextDay = DateTime(day.year, day.month, day.day + 1);

      for (
        var time = day;
        time.isBefore(nextDay);
        time = time.add(const Duration(hours: 1))
      ) {
        if (!time.isBefore(_viewport.start) && !time.isAfter(_viewport.end)) {
          times.add(time);
        }
      }

      day = nextDay;
    }

    return times;
  }

  @override
  Widget build(BuildContext context) {
    final axisColor = Theme.of(context).colorScheme.onSurface;

    final lineDecoration = BoxDecoration(
      color: axisColor,
      borderRadius: BorderRadius.circular(2),
    );

    return SizedBox(
      width: double.infinity,
      height: 96,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          if (width <= 0) {
            return const SizedBox.shrink();
          }

          const axisY = 48.0;

          final focusedDay = _viewport.focusedDay;
          final focusedDayEnd = DateTime(
            focusedDay.year,
            focusedDay.month,
            focusedDay.day + 1,
          );

          final selectedLeft = _viewport
              .xFor(focusedDay, width)
              .clamp(0.0, width)
              .toDouble();

          final selectedRight = _viewport
              .xFor(focusedDayEnd, width)
              .clamp(0.0, width)
              .toDouble();

          final pixelsPerHour =
              width /
              (_viewport.duration.inMicroseconds /
                  Duration.microsecondsPerHour);

          // подписи между делениями
          final labelStep = [3, 6, 12, 24].firstWhere(
            (hours) => hours * pixelsPerHour >= DateSpot.width + 8,
            orElse: () => 24,
          );

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragUpdate: (details) {
              setState(() {
                _viewport = _viewport.pan(details.delta.dx, width);
              });
            },
            child: ClipRect(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: axisY - 2,
                    height: 4,
                    child: Opacity(
                      opacity: 0.75,
                      child: DecoratedBox(decoration: lineDecoration),
                    ),
                  ),
                  Positioned(
                    left: selectedLeft,
                    width: selectedRight - selectedLeft,
                    top: axisY - 2,
                    height: 4,
                    child: DecoratedBox(decoration: lineDecoration),
                  ),
                  for (final time in _visibleTimes())
                    Positioned(
                      left: _viewport.xFor(time, width) - DateSpot.width / 2,
                      top: axisY - 4,
                      child: DateSpot(
                        time: time,
                        isSelected:
                            !time.isBefore(focusedDay) &&
                            time.isBefore(focusedDayEnd),
                        showLabel: time.hour % labelStep == 0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
