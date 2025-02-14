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
  ThemeExtension<CustomCalendarTheme> copyWith({
    Color? backgroundColor,
    Color? selectedDateColor,
    Color? eventIndicatorColor,
    TextStyle? headerTextStyle,
    TextStyle? todayButtonTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? selectedDateTextStyle,
    TextStyle? todayTextStyle,
  }) {
    return CustomCalendarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedDateColor: selectedDateColor ?? this.selectedDateColor,
      eventIndicatorColor: eventIndicatorColor ?? this.eventIndicatorColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      todayButtonTextStyle: todayButtonTextStyle ?? this.todayButtonTextStyle,
      dateTextStyle: dateTextStyle ?? this.dateTextStyle,
      selectedDateTextStyle: selectedDateTextStyle ?? this.selectedDateTextStyle,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
    );
  }

  @override
  ThemeExtension<CustomCalendarTheme> lerp(
      ThemeExtension<CustomCalendarTheme>? other, double t) {
    if (other is! CustomCalendarTheme) {
      return this;
    }
    return CustomCalendarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      selectedDateColor:
      Color.lerp(selectedDateColor, other.selectedDateColor, t)!,
      eventIndicatorColor:
      Color.lerp(eventIndicatorColor, other.eventIndicatorColor, t)!,
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t)!,
      todayButtonTextStyle:
      TextStyle.lerp(todayButtonTextStyle, other.todayButtonTextStyle, t)!,
      dateTextStyle: TextStyle.lerp(dateTextStyle, other.dateTextStyle, t)!,
      selectedDateTextStyle:
      TextStyle.lerp(selectedDateTextStyle, other.selectedDateTextStyle, t)!,
      todayTextStyle: TextStyle.lerp(todayTextStyle, other.todayTextStyle, t)!,
    );
  }

  static CustomCalendarTheme of(BuildContext context) {
    return Theme.of(context).extension<CustomCalendarTheme>()!;
  }

  // Método para gerar o tema com base no WolfDesignSystemTheme
  static CustomCalendarTheme fromTheme(ThemeData theme) {
    return CustomCalendarTheme(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      selectedDateColor: theme.colorScheme.primary,
      eventIndicatorColor: theme.colorScheme.secondary,
      headerTextStyle: theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      todayButtonTextStyle: theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
      dateTextStyle: theme.textTheme.bodyMedium!,
      selectedDateTextStyle: theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
      ),
      todayTextStyle: theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}