import 'package:flutter/material.dart';

class CustomCalendarYear extends StatefulWidget {
  final int initialYear;
  final int yearsBefore; // Anos para trás a partir do initialYear
  final int yearsAfter; // Anos para frente a partir do initialYear
  final Function(DateTime)? onClickMonth;

  const CustomCalendarYear({
    super.key,
    required this.initialYear,
    this.yearsBefore = 10,
    this.yearsAfter = 10,
    this.onClickMonth,
  });

  @override
  _CustomCalendarYearState createState() => _CustomCalendarYearState();
}

class _CustomCalendarYearState extends State<CustomCalendarYear> {
  late int currentYear;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    currentYear = widget.initialYear;
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildYearNavigationControls(),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                currentYear = widget.initialYear + page;
              });
            },
            itemBuilder: (context, page) {
              final year = widget.initialYear + page;
              return _buildYearGrid(year);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildYearNavigationControls() {
    return Row(
      // Controles de navegação entre anos
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              currentYear--;
              _pageController.animateToPage(
                currentYear - widget.initialYear,
                // Calcula a página correta
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Text(
          currentYear.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              currentYear++;
              _pageController.animateToPage(
                currentYear - widget.initialYear,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  Widget _buildYearGrid(int year) {
    final months = List.generate(12, (index) => DateTime(year, index + 1));
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final monthDate = months[index];
        final bool isCurrentMonth = monthDate.month == DateTime.now().month &&
            monthDate.year == DateTime.now().year;

        return GestureDetector(
          onTap: () {
            widget.onClickMonth!(DateTime(year));
          },
          child: Hero(
            tag: 'animacao-calendario',
            child: Container(
              decoration: BoxDecoration(
                color: isCurrentMonth
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(nameOfMonth(monthDate.month),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCurrentMonth
                            ? Theme.of(context).primaryColor
                            : null)),
                MonthMiniView(monthDate: monthDate),
                // Mini visualização do mês
              ]),
            ),
          ),
        );
      },
    );
  }

  String nameOfMonth(int month) {
    // Lidar com entradas inválidas
    if (month < 1 || month > 12) {
      return 'Mês inválido'; // Ou lance uma exceção, dependendo da sua necessidade
    }

    final List<String> monthNames = [
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro"
    ];

    return monthNames[month - 1];
  }
}

// Mini visualização do mês
class MonthMiniView extends StatelessWidget {
  final DateTime monthDate;

  const MonthMiniView({super.key, required this.monthDate});

  @override
  Widget build(BuildContext context) {
    final lastDayOfMonth = DateTime(monthDate.year, monthDate.month + 1, 0);
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(monthDate.year, monthDate.month, 1);
    final weekdayOfFirstDay =
        firstDayOfMonth.weekday; // 1 (Segunda) a 7 (Domingo)

    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 7 dias por semana
          childAspectRatio: 1.3,
        ),
        itemCount: lastDayOfMonth.day + weekdayOfFirstDay,
        itemBuilder: (context, index) {
          final day = index + 1 - weekdayOfFirstDay; // Calcula o dia
          final isToday = day == now.day &&
              monthDate.month == now.month &&
              monthDate.year == now.year;
          final bool isWithinMonth = day >= 1 && day <= lastDayOfMonth.day;

          if (!isWithinMonth) {
            // Célula vazia antes do início do mês
            return const SizedBox.shrink();
          } else {
            return Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                    fontSize: 10,
                    color: isToday ? Theme.of(context).primaryColor : null),
              ),
            );
          }
        },
      ),
    );
  }
}
