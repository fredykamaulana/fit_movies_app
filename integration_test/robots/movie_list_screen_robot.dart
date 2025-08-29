import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MovieListScreenRobot {
  final WidgetTester tester;

  MovieListScreenRobot({required this.tester});

  Future<void> tapSearchIcon() async {
    final mainMenuFinder = find.byKey(const Key('mainMenuNavbar'));
    final searchIconFinder = find.byKey(const Key('searchIcon'));

    // Scroll the main menu navbar to the end to make the search icon visible
    await tester.drag(mainMenuFinder, const Offset(-500.0, 0.0));

    // Ensure the search icon is visible before tapping
    await tester.ensureVisible(searchIconFinder);

    // Tap the search icon
    await tester.tap(searchIconFinder);

    // Wait for the UI to settle after the tap
    await tester.pumpAndSettle();
  }
}
