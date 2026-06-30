import 'package:flutter_test/flutter_test.dart';
import 'package:skoleom_care/main.dart';

void main() {
  testWidgets('Skoleom Care affiche son accueil', (tester) async {
    await tester.pumpWidget(const SkoleomCareApp());
    await tester.pumpAndSettle();
    expect(find.text('Skoleom Care'), findsWidgets);
    expect(find.text('Respire. Ecoute. Reviens a toi.'), findsOneWidget);
  });
}
