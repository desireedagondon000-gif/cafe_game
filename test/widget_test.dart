import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_game/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const CafeGameApp());

    expect(find.text('Bloom Brew Café 🌸'), findsOneWidget);
  });
}
