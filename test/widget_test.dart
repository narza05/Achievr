import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:achievr/src/features/auth/view/login.dart';
import 'package:achievr/src/features/auth/viewmodels/auth_provider.dart';

void main() {
  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    // Build the Login screen wrapped in the necessary provider.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
          home: Login(),
        ),
      ),
    );

    // Verify that the Google sign in button is present.
    expect(find.text('Google sign in'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
