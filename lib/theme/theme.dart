import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.accentColor,
    textTheme: TextTheme(
      bodyText1: AppTypography.bodyText1.copyWith(
        color: Colors.white.withOpacity(0.8),
      ),
      bodyText2: AppTypography.bodyText2.copyWith(
        color: Colors.white.withOpacity(0.6),
      ),
      headline6: AppTypography.headline6.copyWith(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.accentColor,
        onPrimary: AppColors.primaryColor,
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.accentColor,
    textTheme: TextTheme(
      bodyText1: AppTypography.bodyText1,
      bodyText2: AppTypography.bodyText2,
      headline6: AppTypography.headline6,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.accentColor,
        onPrimary: AppColors.primaryColor,
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static final ThemeData futureTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.accentColor,
    textTheme: TextTheme(
      bodyText1: AppTypography.bodyText1.copyWith(
        color: Colors.white.withOpacity(0.8),
      ),
      bodyText2: AppTypography.bodyText2.copyWith(
        color: Colors.white.withOpacity(0.6),
      ),
      headline6: AppTypography.headline6.copyWith(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.accentColor,
        onPrimary: AppColors.primaryColor,
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    ),
  );

  static Color getTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white : Colors.black;
  }
}
