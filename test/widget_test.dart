import 'package:flutter_test/flutter_test.dart';

import 'package:owocloak_windows/app/owocloak_app.dart';

void main() {
  testWidgets('opens in simple mode', (tester) async {
    await tester.pumpWidget(const OwOCloakApp());

    expect(find.text('OwOCloak'), findsOneWidget);
    expect(find.text('Простой'), findsOneWidget);
    expect(find.text('Отключено'), findsOneWidget);
  });

  testWidgets('connect action goes through the shared controller',
      (tester) async {
    await tester.pumpWidget(const OwOCloakApp());

    await tester.tap(find.text('Отключено'));
    await tester.pump();
    expect(find.text('Подключение…'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));
    expect(find.text('Подключено'), findsOneWidget);
  });
}
