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

class CalendarYearPage extends StatelessWidget {
   CalendarYearPage({super.key});

 final DateTime data = DateTime(2025, 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
      ),
      body: CustomCalendarYear(
        initialYear: 2025,
        onClickMonth: (data) {
          Navigator.of(context).push(
              PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: const CustomCalendarMonth(
                    locale: Locale('pt', 'BR'), // Tag única para o Hero
                  ),
                ),
              );
            },
          ));
        },
      ),
    );
  }
}
