

import 'package:flutter/material.dart';

class CustomCalendarTheme extends ThemeExtension<CustomCalendarTheme> {
  final Color backgroundColor;
  final Color selectedDateColor;
  final Color eventIndicatorColor;
  final TextStyle headerTextStyle;
  final TextStyle todayButtonTextStyle;
  final TextStyle dateTextStyle;
  final TextStyle selectedDateTextStyle;
  final TextStyle todayTextStyle;

  const CustomCalendarTheme({
    required this.backgroundColor,
    required this.selectedDateColor,
    required this.eventIndicatorColor,
    required this.headerTextStyle,
    required this.todayButtonTextStyle,
    required this.dateTextStyle,
    required this.selectedDateTextStyle,
    required this.todayTextStyle,
  });

  @override
  ThemeExtension<CustomCalendarTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<CustomCalendarTheme> lerp(
      ThemeExtension<CustomCalendarTheme>? other, double t) {
    return this;
  }

  static CustomCalendarTheme of(BuildContext context) {
    return Theme.of(context).extension<CustomCalendarTheme>()!;
  }
}