import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolfdeveloper_ui_kit/wolfdeveloper_ui_kit.dart';

void main() {
  testWidgets('ListOfServices exibe a lista de strings corretamente',
      (WidgetTester tester) async {
    final stringList = ['Serviço 1', 'Serviço 2', 'Serviço 3'];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListOfServices(stringList: stringList),
      ),
    ));

    // Verifica se cada string da lista é exibida.
    for (final string in stringList) {
      expect(find.text(string), findsOneWidget);
    }
    // Verifica se o número de separadores está correto (um a menos que o número de itens).
    expect(find.byType(SizedBox), findsNWidgets(stringList.length));
  });

  testWidgets('ListOfServices lida com lista vazia',
      (WidgetTester tester) async {
    final stringList = <String>[];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListOfServices(stringList: stringList),
      ),
    ));

    expect(find.byKey(const Key('lista_nao_vazia')),
        findsNothing); // Use a chave para verificar
  });

  testWidgets('ListOfServices renderiza um Card', (WidgetTester tester) async {
    final stringList = ['Serviço 1', 'Serviço 2', 'Serviço 3'];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListOfServices(stringList: stringList),
      ),
    ));

    expect(find.byType(Card), findsOneWidget);
  });
}
