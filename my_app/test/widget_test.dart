import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_app/main.dart';
import 'package:my_app/services/todo_service.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final todoService = TodoService(prefs);

    // Build the app
    await tester.pumpWidget(MyApp(todoService: todoService));

    // Verify that the app bar title is displayed
    expect(find.text('TODOリスト'), findsOneWidget);

    // Verify that the floating action button exists
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
