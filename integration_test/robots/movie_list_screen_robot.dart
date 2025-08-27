import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MovieListScreenRobot {
  final WidgetTester tester;

  MovieListScreenRobot({required this.tester});

  Future<void> tapSearchIcon() async {
    final searchIconFinder = find.byKey(Key('search_icon_button'));

    await tester.ensureVisible(searchIconFinder);
    await tester.tap(searchIconFinder);
    await tester.pumpAndSettle();
  }
}
