import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wolfdeveloper_ui_kit/src/themes/custom_calendar_theme.dart';

class CustomCalendar extends StatefulWidget {
  final Locale locale;
  final Function(DateTime)? onDateSelected;

  const CustomCalendar({
    Key? key,
    required this.locale,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar>
    with SingleTickerProviderStateMixin {
  late DateTime _currentDate;
  late DateTime _selectedDate;
  late AnimationController _animationController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _selectedDate = DateTime.now();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _pageController = PageController(initialPage: _currentDate.month - 1);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTodayPressed() {
    setState(() {
      _currentDate = DateTime.now();
      _selectedDate = DateTime.now();
      _pageController.animateToPage(
        _currentDate.month - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = CustomCalendarTheme.of(context);
    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentDate = DateTime(_currentDate.year, index + 1);
                });
              },
              itemBuilder: (context, index) {
                return _buildMonthView(DateTime(_currentDate.year, index + 1));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final theme = CustomCalendarTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            child: Text(
              'Hoje',
              style: theme.todayButtonTextStyle,
            ),
            onPressed: _onTodayPressed,
          ),
          Text(
            '${_currentDate.month}/${_currentDate.year}',
            style: theme.headerTextStyle,
          ),
          const SizedBox(width: 48.0), // Espaço para alinhamento
        ],
      ),
    );
  }

  Widget _buildMonthView(DateTime month) {
    final theme = CustomCalendarTheme.of(context);
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: daysInMonth + startingWeekday - 1,
      itemBuilder: (context, index) {
        if (index < startingWeekday - 1) {
          return Container(); // Dias do mês anterior
        }
        final day = index - startingWeekday + 2;
        final date = DateTime(month.year, month.month, day);
        final isSelected = date == _selectedDate;
        final isToday = date == DateTime.now();
        return GestureDetector(
          onTap: () => _onDateSelected(date),
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
                    color: theme.selectedDateColor,
                    shape: BoxShape.circle,
                  )
                : null,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$day',
                  style: isToday
                      ? theme.todayTextStyle
                      : isSelected
                          ? theme.selectedDateTextStyle
                          : theme.dateTextStyle,
                ),
                if (date.weekday == DateTime.sunday) // Exemplo de evento
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    width: 4.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: theme.eventIndicatorColor,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}


