part of 'theme.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  scaffoldBackgroundColor: AppColors.white,

  colorScheme: const ColorScheme.light(
    primary: AppColors.graphite,
    onPrimary: AppColors.softWhite,

    surface: AppColors.softWhite,
    onSurface: AppColors.graphite,
  ),

  iconTheme: const IconThemeData(color: AppColors.graphite),
  fontFamily: 'Inter',
);
