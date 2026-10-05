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
    final fadedColor = axisColor.withValues(alpha: 0.75);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        if (width <= 0 || height <= 0) {
          return const SizedBox.shrink();
        }

        final axisY = height / 2;
        const lineThickness = 2.0;

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
            (_viewport.duration.inMicroseconds / Duration.microsecondsPerHour);

        final labelStep = [1, 3, 6, 12, 24].firstWhere(
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
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: axisY - lineThickness / 2,
                  height: lineThickness,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child: Row(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: selectedLeft,
                          child: ColoredBox(color: fadedColor),
                        ),
                        SizedBox(
                          width: selectedRight - selectedLeft,
                          child: ColoredBox(color: fadedColor),
                        ),
                      ],
                    ),
                  ),
                ),
                for (final time in _visibleTimes())
                  Positioned(
                    left: _viewport.xFor(time, width) - DateSpot.width / 2,
                    top: axisY - DateSpot.axisOffset(context),
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
    );
  }
}
