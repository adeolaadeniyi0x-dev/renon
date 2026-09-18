import 'package:flutter_test/flutter_test.dart';

import 'package:renon/app/app.dart';

void main() {
  testWidgets('Renon app shows the welcome screen', (tester) async {
    await tester.pumpWidget(const RenonApp());

    expect(find.text('RENON'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });
}
