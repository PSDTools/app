import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pirate_code_3/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders a Material App', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
