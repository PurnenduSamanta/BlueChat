import 'package:flutter_test/flutter_test.dart';

import 'package:blue_chat/app.dart';

void main() {
  testWidgets('Device listing screen is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const BlueChatApp());
    await tester.pump();

    expect(find.text('Nearby Devices'), findsOneWidget);
  });
}
