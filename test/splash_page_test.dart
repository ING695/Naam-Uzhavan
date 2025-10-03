import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naam_uzhavan/features/auth/presentation/pages/splash_page.dart';

void main() {
  testWidgets('SplashPage displays app name and loading indicator',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashPage(),
      ),
    );

    // Verify that the app name is displayed
    expect(find.text('Naam Uzhavan'), findsOneWidget);

    // Verify that the agriculture icon is displayed
    expect(find.byIcon(Icons.agriculture), findsOneWidget);

    // Verify that the loading indicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
