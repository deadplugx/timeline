import 'package:flutter/material.dart';

class DateSpot extends StatelessWidget {
  const DateSpot({
    super.key,
    required this.time,
    required this.isSelected,
    required this.showLabel,
  });

  static const double width = 64;

  final DateTime time;
  final bool isSelected;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    final isDayStart = time.hour == 0 && time.minute == 0;
    final dotSize = isDayStart ? 8.0 : 6.0;

    final date =
        '${time.day.toString().padLeft(2, '0')}.'
        '${time.month.toString().padLeft(2, '0')}';

    final clock =
        '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';

    return Opacity(
      opacity: isSelected ? 1 : 0.75,
      child: SizedBox(
        width: width,
        height: 48,
        child: Column(
          children: [
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
            if (showLabel)
              Text(
                isDayStart ? date : clock,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: color, fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
