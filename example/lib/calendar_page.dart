import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wolfdeveloper_ui_kit/wolfdeveloper_ui_kit.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Calendário Custom'),
      ),
      child: SafeArea(
        child: CustomCalendar(
          locale: const Locale('pt', 'BR'),
          onDateSelected: (date) {
            print('Data selecionada: $date');
          },
        ),
      ),
    );
  }
}
