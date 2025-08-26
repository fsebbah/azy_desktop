import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:azy_desktop/main.dart';
import 'package:azy_desktop/screens/login_screen.dart';

void main() {
  testWidgets('Login screen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AzyDesktopApp());

    // Verify that login screen elements are present
    expect(find.text('Chat Studio'), findsOneWidget);
    // The subtitle is in French by default
    expect(find.text('Votre assistant de conversation intelligent'), findsOneWidget);
    
    // Verify form fields are present
    expect(find.byType(TextFormField), findsNWidgets(2)); // Email and password fields
    
    // Scroll to make sure buttons are visible
    await tester.ensureVisible(find.text('Se connecter'));
    await tester.pump();
    
    // Verify buttons are present (in French by default)
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.text('Se connecter avec Google'), findsOneWidget);
    expect(find.text('Se connecter avec Microsoft'), findsOneWidget);
    expect(find.text('Créer une organisation'), findsOneWidget);
    
    // Verify language selector is present
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    
    // Verify remember me checkbox
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('Language selector works', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    ));
    
    // Initially in French
    expect(find.text('Votre assistant de conversation intelligent'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
    
    // Find and tap the language dropdown
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    
    // Select English
    await tester.tap(find.text('English').last);
    await tester.pumpAndSettle();
    
    // Verify text changed to English
    expect(find.text('Your intelligent conversation assistant'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.text('Create an organization'), findsOneWidget);
  });

  testWidgets('Login form validation works', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    ));

    // Ensure the form is visible
    await tester.ensureVisible(find.text('Se connecter'));
    await tester.pump();
    
    // Find the sign in button and tap it
    final signInButton = find.text('Se connecter');
    await tester.tap(signInButton);
    await tester.pumpAndSettle();
    
    // Verify validation messages appear
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    
    // Enter invalid email
    await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
    await tester.tap(signInButton);
    await tester.pumpAndSettle();
    
    expect(find.text('Please enter a valid email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    
    // Enter valid email but short password
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).last, '123');
    await tester.tap(signInButton);
    await tester.pumpAndSettle();
    
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Password visibility toggle works', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    ));
    
    // Ensure password field is visible
    final passwordField = find.byType(TextFormField).last;
    await tester.ensureVisible(passwordField);
    await tester.pump();
    
    // Find the visibility toggle icon (initially showing visibility_off because password is hidden)
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    
    // Tap the visibility toggle
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();
    
    // Now it should show visibility icon (password is visible)
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsNothing);
    
    // Tap again to hide password
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();
    
    // Should be back to visibility_off icon
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);
  });

  testWidgets('Remember me checkbox works', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    ));
    
    // Find the checkbox
    final checkbox = find.byType(Checkbox);
    await tester.ensureVisible(checkbox);
    await tester.pump();
    
    // Initially unchecked
    Checkbox checkboxWidget = tester.widget(checkbox);
    expect(checkboxWidget.value, false);
    
    // Tap to check
    await tester.tap(checkbox);
    await tester.pump();
    
    // Now should be checked
    checkboxWidget = tester.widget(checkbox);
    expect(checkboxWidget.value, true);
  });

  testWidgets('OAuth buttons are present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    ));
    
    // Ensure OAuth section is visible
    await tester.ensureVisible(find.text('Se connecter avec Google'));
    await tester.pump();
    
    // Verify OAuth buttons
    expect(find.text('Se connecter avec Google'), findsOneWidget);
    expect(find.text('Se connecter avec Microsoft'), findsOneWidget);
    
    // Verify divider text
    expect(find.text('ou continuez avec vos comptes'), findsOneWidget);
  });

  testWidgets('Can enter email and password', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    ));
    
    // Enter email
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, 'user@example.com');
    expect(find.text('user@example.com'), findsOneWidget);
    
    // Enter password  
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, 'password123');
    
    // Password should be obscured, so we shouldn't see the actual text
    // but the field should contain it
    final TextFormField passwordWidget = tester.widget(passwordField);
    expect(passwordWidget.controller?.text, 'password123');
  });
}