import 'package:flutter_test/flutter_test.dart';
import 'package:flotter1/main.dart';
import 'package:flotter1/data/breeding_database.dart';
import 'package:flotter1/data/ark_map_database.dart';
import 'package:flotter1/models/breeding_data.dart';

void main() {
  testWidgets('ARK Encyclopedia & Navigation smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ArkEncyclopediaApp());

    // Verify main header and bottom navigation items
    expect(find.text('ЕНЦИКЛОПЕДІЯ ДИНОЗАВРІВ'), findsOneWidget);
    expect(find.text('ЕНЦИКЛОПЕДІЯ'), findsOneWidget);
    expect(find.text('РОЗВЕДЕННЯ'), findsOneWidget);
    expect(find.text('КАРТИ'), findsOneWidget);

    // Switch to Breeding tab
    await tester.tap(find.text('РОЗВЕДЕННЯ'));
    await tester.pumpAndSettle();
    expect(find.text('КАЛЬКУЛЯТОР РОЗВЕДЕННЯ'), findsOneWidget);
    expect(find.text('СЕРВЕРНІ МНОЖНИКИ (RATES)'), findsOneWidget);

    // Switch to Maps tab
    await tester.tap(find.text('КАРТИ'));
    await tester.pumpAndSettle();
    expect(find.text('ІНТЕРАКТИВНІ КАРТИ'), findsOneWidget);
    expect(find.text('ПІНЧ ДЛЯ ЗУМУ'), findsOneWidget);
  });

  test('Breeding Calculator math verification', () {
    final rex = BreedingDatabase.creatures.firstWhere((c) => c.id == 'rex');
    expect(rex.isEgg, isTrue);

    // 1x official rates
    expect(rex.getIncubationSeconds(1.0), equals(18000));
    expect(rex.getBabySeconds(1.0), equals((333300 * 0.10).round()));

    // 5x server rate
    expect(rex.getIncubationSeconds(5.0), equals(3600)); // 18000 / 5 = 3600s (1h)
    expect(BreedingCreature.formatDuration(3600), equals('1г'));
    expect(BreedingCreature.formatDuration(18000), equals('5г'));

    // Baby food consumption
    expect(rex.getBabyFoodQuantity(1.0), greaterThan(0));
    expect(rex.getImprintCount(1.0), greaterThan(0));
  });

  test('Interactive Maps GPS coordinates validation', () {
    expect(ArkMapDatabase.maps.isNotEmpty, isTrue);

    for (final map in ArkMapDatabase.maps) {
      expect(map.markers.isNotEmpty, isTrue);
      for (final marker in map.markers) {
        expect(marker.lat, inInclusiveRange(0.0, 100.0));
        expect(marker.lon, inInclusiveRange(0.0, 100.0));
        expect(marker.titleUa.isNotEmpty, isTrue);
      }
    }
  });
}
