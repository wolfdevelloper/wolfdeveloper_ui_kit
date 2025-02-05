import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolfdeveloper_ui_kit/wolfdeveloper_ui_kit.dart';

void main() {
  group('ExpandableContent', () {
    testWidgets('exibe conteúdo corretamente quando colapsado',
        (WidgetTester tester) async {
      const leftText = 'Left Text';
      const rightText = 'Right Text';
      const content = Text('Content');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableContent(
              leftText: leftText,
              rightText: rightText,
              content: content,
            ),
          ),
        ),
      );

      expect(find.text(leftText), findsOneWidget);
      expect(find.text(rightText), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_up),
          findsOneWidget); // Ícone para expandir
      expect(find.text(content.data!),
          findsNothing); // Conteúdo não deve ser visível
    });

    testWidgets('exibe conteúdo corretamente quando expandido',
        (WidgetTester tester) async {
      const leftText = 'Left Text';
      const rightText = 'Right Text';
      const content = Text('Content');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableContent(
              leftText: leftText,
              rightText: rightText,
              content: content,
            ),
          ),
        ),
      );

      // Toque para expandir
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.text(leftText), findsOneWidget);
      expect(find.text(rightText), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down),
          findsOneWidget); // Ícone para colapsar
      expect(find.text(content.data!),
          findsOneWidget); // Conteúdo deve ser visível
    });

    testWidgets('alterna o estado expandido/colapsado corretamente',
        (WidgetTester tester) async {
      const leftText = 'Left Text';
      const rightText = 'Right Text';
      const content = Text('Content');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableContent(
              leftText: leftText,
              rightText: rightText,
              content: content,
            ),
          ),
        ),
      );

      // Verifica o estado inicial (colapsado)
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);

      // Toque para expandir
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Verifica o estado expandido
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);

      // Toque novamente para colapsar
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Verifica o estado colapsado novamente
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
    });
  });
}
