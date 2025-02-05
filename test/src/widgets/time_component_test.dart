import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolfdeveloper_ui_kit/src/themes/wolf_desing_system_theme.dart';
import 'package:wolfdeveloper_ui_kit/src/widgets/time_component.dart'; // Importe o seu plugin

void main() {
  group('TimeComponent', () {
    testWidgets('exibe chips com os tempos fornecidos', (WidgetTester tester) async {
      const times = ['10:00', '12:00', '14:00'];

      await tester.pumpWidget(
        MaterialApp(
          theme: WolfDesignSystemTheme.lightTheme, // Tema claro
          darkTheme: WolfDesignSystemTheme.darkTheme, // Tema escuro
          themeMode: ThemeMode.system, // Modo de tema (opcional)
          home:  const Scaffold(
            body: TimeComponent(times: times),
          ),
        ),
      );

      expect(find.byType(Chip), findsNWidgets(times.length));
      for (final time in times) {
        expect(find.text(time), findsOneWidget);
      }

      final chipWidget = find.byType(Chip).first;
      final chipText = tester.widget<Chip>(chipWidget).label as Text;
      // Use Theme.of() para obter o tema correto
      final theme = Theme.of(tester.element(chipWidget));

      // Compare com as propriedades do tema definido
      expect(chipText.style!.color, equals(theme.textTheme.displayMedium!.color));
      expect(chipText.style!.fontSize, equals(theme.textTheme.displayMedium!.fontSize));

      final chipFinder = find.byType(Chip).first;
      final chip = tester.widget<Chip>(chipFinder);

      expect(chip.backgroundColor, equals(theme.colorScheme.secondary));
      expect(chip.side!.color, equals(theme.colorScheme.secondary));

    });

    testWidgets('não exibe nada quando a lista de tempos está vazia', (WidgetTester tester) async {
      // Crie os dados de teste (lista vazia)
      const times = <String>[];

      // Construa o widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimeComponent(times: times),
          ),
        ),
      );

      // Verifique se nenhum Chip foi criado
      expect(find.byType(Chip), findsNothing);
      expect(find.byType(Wrap), findsOneWidget); // O Wrap ainda existe, mas sem filhos
    });


    testWidgets('Renderiza TimeComponent com tema customizado', (WidgetTester tester) async {

      const times = ['10:00', '12:00'];
      const customColor = Colors.pink;

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(colorScheme: const ColorScheme.light(secondary: customColor)),
        home: const Scaffold(
            body: TimeComponent(times: times)
        ),
      ));

      final chipFinder = find.byType(Chip).first;
      final chip = tester.widget<Chip>(chipFinder);

      expect(chip.backgroundColor, equals(customColor));
      expect(chip.side!.color, equals(customColor));
    });
  });
}
