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
      // Start the app
      app.main();
      await tester.pumpWidget(app.MyApp());

      // Wait for the app to settle
      await tester.pumpAndSettle();

      // Initialize the robot with the tester
      movieListScreenRobot = MovieListScreenRobot(tester: tester);

      // Tap the search icon using the robot
      await movieListScreenRobot.tapSearchIcon();

      // Verify that the search widget is displayed
      expect(find.byKey(const Key('searchBar')), findsOneWidget);

      // Report the result to the integration test binding
      binding.reportData = <String, dynamic>{'result': 'passed'};
    });
  });
}
