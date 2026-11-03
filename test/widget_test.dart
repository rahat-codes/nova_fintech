
import 'package:flutter_test/flutter_test.dart';
import 'package:nova_fintech/app/app.dart';

void main() {
  testWidgets(
    'Nova onboarding navigates to the Home dashboard',
        (tester) async {
      await tester.pumpWidget(const NovaApp());
      await tester.pumpAndSettle();

      // Verify onboarding.
      expect(find.text('nova'), findsOneWidget);
      expect(
        find.text('Open an account in 3 minutes'),
        findsOneWidget,
      );
      expect(find.text('Go to app'), findsOneWidget);

      // Scroll the button into view.
      final button = find.text('Go to app');

      await tester.ensureVisible(button);
      await tester.pumpAndSettle();

      // Navigate to Home.
      await tester.tap(button);
      await tester.pumpAndSettle();

      // Verify Home dashboard.
      expect(find.text('Daniel Lauren'), findsOneWidget);
      expect(find.text('TOTAL BALANCE'), findsOneWidget);
      expect(find.text('€33,350'), findsOneWidget);
      expect(find.text('Recent transactions'), findsOneWidget);
    },
  );
}
