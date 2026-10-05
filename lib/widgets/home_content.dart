import 'package:flutter/material.dart';
import 'timeline_baseline.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const TimelineBaseline(),
        Positioned(
          right: 22,
          bottom: 10,
          width: 79,
          height: 79,
          child: IconButton(
            tooltip: 'Create',
            padding: EdgeInsets.zero,
            iconSize: 79,
            icon: Image.asset(
              'assets/icons/iconCreate.png',
              fit: BoxFit.contain,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('бля'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
