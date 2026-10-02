import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/home_screen.dart';
import 'themes/theme.dart';

void main() {
  runApp(const TimeLineApp());
}

class TimeLineApp extends StatelessWidget {
  const TimeLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('en'), Locale('ru')],
      home: const HomeScreen(),
    );
  }
}
