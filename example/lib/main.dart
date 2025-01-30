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
      title: 'Flutter Demo',
      theme: WolfDesignSystemTheme.lightTheme,
      darkTheme: WolfDesignSystemTheme.darkTheme,
      // Opcional: tema escuro
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'wolfdeveloper Ui Kit'),
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
      stringList: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
    ),
    // ... adicione outros componentes aqui
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wolfdeveloper Ui Kit')),
      body: Padding(
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

          ],
        ),
      ),
    );
  }
}
