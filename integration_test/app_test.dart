import 'package:fit_movies_app/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/movie_list_screen_robot.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  MovieListScreenRobot movieListScreenRobot;

  group('Movie List Screen Tests', () {
    testWidgets('Test Search Icon Navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Initialize the robot with the tester
      movieListScreenRobot = MovieListScreenRobot(tester: tester);

      print('Before tapping search icon');
      // Tap the search icon using the robot
      await movieListScreenRobot.tapSearchIcon();
      print('After tapping search icon');

      // Verify that the search widget is displayed
      expect(find.byKey(Key('floating_search_bar')), findsOneWidget);
      print('Search widget displayed');

      // Report the result to the integration test binding
      binding.reportData = <String, dynamic>{'result': 'passed'};
    });
  });
}
