import 'package:flutter/material.dart';

class DateSpot extends StatelessWidget {
  const DateSpot({
    super.key,
    required this.time,
    required this.isSelected,
    required this.showLabel,
  });

  static const double width = 64;
  static double axisOffset(BuildContext context) {
    final labelHeight = MediaQuery.textScalerOf(context).scale(11) * 1.4;
    return labelHeight + 8 + 4;
  }

  final DateTime time;
  final bool isSelected;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    final isDayStart = time.hour == 0 && time.minute == 0;
    final dotSize = isDayStart ? 8.0 : 6.0;
    final labelHeight = MediaQuery.textScalerOf(context).scale(11) * 1.4;

    final date =
        '${time.day.toString().padLeft(2, '0')}.'
        '${time.month.toString().padLeft(2, '0')}';

    final clock =
        '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';

    final labelStyle = TextStyle(
      color: color,
      fontSize: 11,
      height: 1.4,
      fontWeight: FontWeight.w400,
    );

    return Opacity(
      opacity: isSelected ? 1 : 0.75,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // место под дату сохраняется у часовых точек
            SizedBox(
              height: labelHeight,
              child: isDayStart
                  ? Center(
                      child: Text(
                        date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: labelStyle.copyWith(fontWeight: FontWeight.w700),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 8,
              child: Center(
                child: Tooltip(
                  message: '$date.${time.year} $clock',
                  child: Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: labelHeight,
              child: isDayStart || showLabel
                  ? Center(
                      child: Text(
                        clock,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: labelStyle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
