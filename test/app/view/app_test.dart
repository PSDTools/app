import 'package:flutter_test/flutter_test.dart';
import 'package:pirate_code_3/app/app.dart';
import 'package:pirate_code_3/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
