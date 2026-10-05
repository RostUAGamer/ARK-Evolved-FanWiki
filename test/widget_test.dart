import 'package:flutter_test/flutter_test.dart';
import 'package:flotter1/main.dart';

void main() {
  testWidgets('ARK Encyclopedia smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ArkEncyclopediaApp());

    // Verify that title and some dinosaur engrams appear.
    expect(find.text('ЕНЦИКЛОПЕДІЯ ДИНОЗАВРІВ'), findsOneWidget);
    expect(find.text('ФІЛЬТР'), findsOneWidget);
  });
}
