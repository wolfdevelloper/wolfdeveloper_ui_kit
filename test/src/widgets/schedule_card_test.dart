import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolfdeveloper_ui_kit/wolfdeveloper_ui_kit.dart'; // Importe o seu pacote aqui

void main() {
  testWidgets('ScheduleCard exibe informações corretamente',
      (WidgetTester tester) async {
    final scheduledTime = DateTime.now().add(const Duration(minutes: 45));
    const firstName = 'John';
    const lastName = 'Doe';
    const age = 30;
    final services = ['Corte', 'Pintura'];
    const phoneNumber = '(11) 99999-9999';
    const address = 'Rua Teste, 123';
    final facilities = ['Wi-fi', 'Ar-condicionado'];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ScheduleCard(
          firstName: firstName,
          lastName: lastName,
          age: age,
          scheduledTime: scheduledTime,
          services: services,
          phoneNumber: phoneNumber,
          address: address,
          facilities: facilities,
          onTap: () {},
        ),
      ),
    ));

    // Verifica se o nome é exibido corretamente.
    expect(find.text('$firstName $lastName'), findsOneWidget);

    // Verifica se a hora agendada é exibida corretamente.
    final formattedScheduledTime =
        '${scheduledTime.hour.toString().padLeft(2, '0')}:${scheduledTime.minute.toString().padLeft(2, '0')}';
    expect(find.text(formattedScheduledTime), findsOneWidget);

    // Verifica se os serviços são exibidos como Chips.
    expect(find.text(services[0]), findsOneWidget);
    expect(find.text(services[1]), findsOneWidget);

    // Verifica se o número de telefone é exibido corretamente.
    expect(find.text(phoneNumber), findsOneWidget);

    // Verifica se o endereço é exibido corretamente.
    expect(find.text(address), findsOneWidget);

    // Verifica se as facilidades são exibidas como Chips.
    expect(find.text(facilities[0]), findsOneWidget);
    expect(find.text(facilities[1]), findsOneWidget);

    // Verifica a cor do ícone com base na diferença de tempo.
    final currentTime = DateTime.now();
    final timeDifference = scheduledTime.difference(currentTime);

    if (timeDifference > const Duration(minutes: 30)) {
      expect(find.byIcon(Icons.circle), findsOneWidget);
      expect(
          (tester.widget<Icon>(find.byIcon(Icons.circle)).color), Colors.green);
    } else if (timeDifference > const Duration(minutes: 10)) {
      expect(find.byIcon(Icons.circle), findsOneWidget);
      expect((tester.widget<Icon>(find.byIcon(Icons.circle)).color),
          Colors.yellow);
    } else {
      expect(find.byIcon(Icons.circle), findsOneWidget);
      expect(
          (tester.widget<Icon>(find.byIcon(Icons.circle)).color), Colors.red);
    }
  });

  testWidgets('ScheduleCard lastName truncado corretamente',
      (WidgetTester tester) async {
    final scheduledTime = DateTime.now().add(const Duration(minutes: 45));
    const firstName = 'John';
    const lastName =
        'Doeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee';
    const age = 30;
    final services = ['Corte', 'Pintura'];
    const phoneNumber = '(11) 99999-9999';
    const address = 'Rua Teste, 123';
    final facilities = ['Wi-fi', 'Ar-condicionado'];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ScheduleCard(
          firstName: firstName,
          lastName: lastName,
          age: age,
          scheduledTime: scheduledTime,
          services: services,
          phoneNumber: phoneNumber,
          address: address,
          facilities: facilities,
          onTap: () {},
        ),
      ),
    ));

    expect(find.text('$firstName ${lastName.substring(0, 15)}...'),
        findsOneWidget);
  });

  testWidgets('ScheduleCard testa o clique no botão',
      (WidgetTester tester) async {
    // ... (Configuração do widget como no teste anterior)

    // Adiciona um listener para o IconButton
    bool buttonPressed = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ScheduleCard(
          firstName: 'primeiro nome ',
          services: const ['servico'],
          facilities: const ['facilidade'],
          address: 'endereco',
          phoneNumber: '11111111111',
          scheduledTime: DateTime.now(),
          lastName: 'segundo nome',
          age: 19,
          onTap: () {
            buttonPressed = true;
          },
        ),
      ),
    ));

    // Toca no IconButton
    await tester.tap(find.byIcon(Icons.circle));
    await tester
        .pump(); // Reconstrói o widget para refletir a mudança de estado

    // Verifica se o botão foi pressionado
    expect(buttonPressed, true);
  });
}
