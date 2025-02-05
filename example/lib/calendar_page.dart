import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wolfdeveloper_ui_kit/wolfdeveloper_ui_kit.dart';

/*class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: WolfDesignSystemTheme.lightTheme.copyWith(
        extensions: [
          CustomCalendarTheme.fromTheme(WolfDesignSystemTheme.lightTheme),
        ],
      ),
      darkTheme: WolfDesignSystemTheme.darkTheme.copyWith(
        extensions: [
          CustomCalendarTheme.fromTheme(WolfDesignSystemTheme.darkTheme),
        ],
      ),
      home: const HomeScreen(),
    );
  }
}*/

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
      ),
      body:  CustomCalendar(
        locale: Locale('pt', 'BR'),
        onDateSelected: (date) {
          print('Data selecionada: $date');
        },
      ),
    );
  }
}