import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolfdeveloper_ui_kit/src/themes/wolf_desing_system_theme.dart';
import 'package:wolfdeveloper_ui_kit/src/widgets/expandable_content.dart';
import 'package:wolfdeveloper_ui_kit/src/widgets/search_result_card.dart';

void main() {
  group('SearchResultCard', () {
    testWidgets('exibe o card com informações corretas',
        (WidgetTester tester) async {
      const imageUrl = 'https://via.placeholder.com/120x120';
      const providerName = 'Nome do Fornecedor';
      const providerAddress = 'Endereço do Fornecedor';
      const rating = 4.0;
      const reviewCount = 10;
      final expandableContentList = [
        const ExpandableContent(
          leftText: 'Título 1',
          rightText: 'Descricao1',
          content: Text('Conteúdo 1'),
        ),
        const ExpandableContent(
          leftText: 'Título 2',
          rightText: 'Descricao2',
          content: Text('Conteúdo 2'),
        ),
      ];
      final cardKey = UniqueKey();

      await tester.pumpWidget(
        MaterialApp(
          theme: WolfDesignSystemTheme.lightTheme,
          darkTheme: WolfDesignSystemTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: Scaffold(
            body: SearchResultCard(
              key: cardKey,
              imageUrl: imageUrl,
              providerName: providerName,
              providerAddress: providerAddress,
              rating: rating,
              reviewCount: reviewCount,
              expandableContentList: expandableContentList,
            ),
          ),
        ),
      );

      // Assegure-se de que apenas um Card é renderizado
      expect(find.byKey(cardKey), findsOneWidget);

      // Use find.byWidgetPredicate para encontrar a Image com a NetworkImage correta.
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Image &&
              widget.image is NetworkImage &&
              (widget.image as NetworkImage).url == imageUrl),
          findsOneWidget);

      expect(find.text(providerName), findsOneWidget);
      expect(find.text(providerAddress), findsOneWidget);
      expect(find.text('Avaliações ($reviewCount)'), findsOneWidget);

      // Verifica as estrelas (4 cheias e 1 vazia)
      expect(find.byIcon(Icons.star), findsNWidgets(4));
      expect(find.byIcon(Icons.star_border), findsOneWidget);

      // Verifica se o conteúdo expansível está presente. É necessário expandir primeiro
      expect(find.text('Título 1'), findsOneWidget);
      expect(find.text('Título 2'), findsOneWidget);
    });

    testWidgets('exibe um placeholder quando a URL da imagem está vazia',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: WolfDesignSystemTheme.lightTheme, // Tema claro
        darkTheme: WolfDesignSystemTheme.darkTheme, // Tema escuro
        themeMode: ThemeMode.system, // Modo de tema (opcional)
        home: const Scaffold(
          body: SearchResultCard(
            imageUrl: '',
            // URL da imagem vazia
            providerName: 'providerName',
            providerAddress: 'providerAddress',
            rating: 4.0,
            reviewCount: 15,
            expandableContentList: [],
          ),
        ),
      ));

      expect(find.byType(Container),
          findsWidgets); // Placeholder deve ser um Container
    });
  });
}
