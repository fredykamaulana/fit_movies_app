import 'package:fit_movies_app/controllers/movie_detail_controller/movie_detail_controller.dart';
import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:fit_movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:fit_movies_app/screens/movie_detail_screen/movie_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../utils/utils.dart';

class MockMovieDetailController extends GetxController
    with Mock
    implements MovieDetailController {}

void main() {
  late MockMovieDetailController mockController;
  late Rx<RemoteState> remoteStateRX;

  setUp(() async {
    mockController = MockMovieDetailController();
    remoteStateRX = Rx<RemoteState>(RemoteStateNone());

    Get.put<MovieDetailController>(mockController);

    //setup hive
    await setUpTestHive();
    var box = await Hive.openBox<FavouriteMovie>('favouriteMovies');
    Get.put<Box<FavouriteMovie>>(box);
  });

  Widget testableWidget(Widget child) {
    return GetMaterialApp(home: child);
  }

  group('MovieDetailScreen Widget Test', () {
    // testWidgets('shows loading indicator', (WidgetTester tester) async {
    //   // Arrange
    //   remoteStateRX.value = RemoteStateLoading();
    //   when(() => mockController.getMovieDetail(any())).thenAnswer((_) async {});

    //   // Return the Rx<RemoteState> itself, not its value
    //   when(() => mockController.remoteState).thenReturn(remoteStateRX);

    //   // Act
    //   await tester.pumpWidget(testableWidget(MovieDetailScreen(movieId: 1)));
    //   await tester.pump(); // Only pump once to allow the widget to build

    //   // Assert
    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // });

    // testWidgets('shows error message', (WidgetTester tester) async {
    //   // Arrange
    //   remoteStateRX.value = RemoteStateError('Failed');
    //   when(() => mockController.getMovieDetail(any()))
    //       .thenAnswer((_) async => {});

    //   // Return the Rx<RemoteState> itself, not its value
    //   when(() => mockController.remoteState).thenReturn(remoteStateRX);

    //   // Act
    //   await tester.pumpWidget(testableWidget(MovieDetailScreen(movieId: 1)));
    //   await tester.pumpAndSettle(Duration(milliseconds: 500));

    //   // Assert
    //   expect(find.text('Failed'), findsOneWidget);
    // });

    testWidgets('shows movie detail content on success',
        (WidgetTester tester) async {
      // Arrange
      remoteStateRX.value =
          RemoteStateSuccess<MovieDetailResponse>(dummyMovieDetailResponse);
      when(() => mockController.getMovieDetail(any()))
          .thenAnswer((_) async => {});

      // Return the Rx<RemoteState> itself, not its value
      when(() => mockController.remoteState).thenReturn(remoteStateRX);

      // Act
      await mockNetworkImagesFor(() async => await tester
          .pumpWidget(testableWidget(MovieDetailScreen(movieId: 1))));
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      // Assert
      expect(find.byType(MovieDetailContent), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });
  });

  tearDown(() async {
    mockController.dispose();
    Get.reset();
    await tearDownTestHive();
  });
}
