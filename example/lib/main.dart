import 'package:example/calendar_page.dart';
import 'package:example/calendar_year_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wolfdeveloper_ui_kit/wolfdeveloper_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      title: 'Flutter Demo',
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
      // Opcional: tema escuro
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'wolfdeveloper Ui Kit'),
      routes: {
        'home': (context) => const MyHomePage(title: 'wolf components',),
        'calendar': (context) => const CalendarPage(),
        'calendar-year': (context) =>  CalendarYearPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedComponent;

  final Map<String, Widget> _components = {
    'ListOfServices': const ListOfServices(
      stringList: ['Corte Masculino', 'Item 2', 'Item 3', 'Item 4'],
    ),
    'ScheduleCard': ScheduleCard(
      firstName: 'joao',
      lastName: 'pereira de souza vasconcelos',
      age: 19,
      scheduledTime: DateTime.now(),
      address: 'rua oscar de barros  - jardim periperi, n35 - sp',
      facilities: const ["cartão de crédito", "Deficiente visual"],
      phoneNumber: "11963542474",
      services: const ["corte + barba", "luzes"],
      onTap: () {},
    ),
    'TimeComponent': const TimeComponent(
      times: ['08:00', '09:00', '10:00', '11:00', '12:00'],
    ),
    'ExpandableContent': const ExpandableContent(
      leftText: 'Nome do Serviço',
      rightText: "R\$100,00",
      content: TimeComponent(
        times: [
          '08:00',
          '09:00',
          '10:00',
        ],
      ),
    ),
    'SearchResultCard': const SearchResultCard(
      rating: 3.0,
      providerAddress: "rua josé augusto sao limoes - br - cotia - sp",
      providerName: 'Douglas Silveira',
      reviewCount: 11,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMzvdGFJ9_-JlZpYPEbc_2SQRnbNA2Ph_k1Q&s',
      expandableContentList: [
        ExpandableContent(
          leftText: 'Nome do Serviço',
          rightText: "R\$100,00",
          content: TimeComponent(
            times: [
              '08:00',
              '09:00',
              '10:00',
            ],
          ),
        ),
        ExpandableContent(
          leftText: 'Nome do Serviço',
          rightText: "R\$100,00",
          content: TimeComponent(
            times: [
              '08:00',
              '09:00',
            ],
          ),
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wolfdeveloper Ui Kit')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            children: [
              DropdownButton<String>(
                value: _selectedComponent,
                hint: const Text('Selecione um componente'),
                items: _components.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedComponent = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              if (_selectedComponent != null)
                Center(
                  child: _components[_selectedComponent!],
                ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('calendar'),
                child: Text('Calendario Mes',style: Theme.of(context).textTheme.headlineMedium,),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('calendar-year'),
                child: Text('Calendario Ano',style: Theme.of(context).textTheme.headlineMedium,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
