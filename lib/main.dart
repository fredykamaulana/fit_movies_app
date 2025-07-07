import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_movies_app/controllers/auth_controller/auth_controller.dart';
import 'package:fit_movies_app/data/auth/firebase_auth_service.dart';
import 'package:fit_movies_app/firebase_options.dart';
import 'package:fit_movies_app/navigations/navigation_routes.dart';
import 'package:fit_movies_app/screens/favourite_screen/favourite_movies_screen.dart';
import 'package:fit_movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:fit_movies_app/screens/movie_list_screen/movie_list_screen.dart';
import 'package:fit_movies_app/screens/register_screen/register_screen.dart';
import 'package:fit_movies_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  await dotenv.load(fileName: ".env");

  // Initialize Firebase instance
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // enable firestore offline mode
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var initialRoute = NavigationRoutes.signin.name;
  final AuthController authController =
      Get.put(AuthController(Get.put(FirebaseAuthService())));

  @override
  Widget build(BuildContext context) {
    final signInState = authController.checkUserSignInState();

    return StreamBuilder<User?>(
        stream: signInState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return MaterialApp(
              title: 'Stay tune the movie!',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
                useMaterial3: true,
              ),
              themeMode: ThemeMode.system,
              initialRoute: snapshot.data != null
                  ? NavigationRoutes.movieList.name
                  : NavigationRoutes.signin.name,
              routes: {
                NavigationRoutes.signin.name: (context) => SignInScreen(),
                NavigationRoutes.register.name: (context) => RegisterScreen(),
                NavigationRoutes.movieList.name: (context) => MovieListScreen(),
                NavigationRoutes.movieDetail.name: (context) =>
                    MovieDetailScreen(
                      movieId:
                          ModalRoute.of(context)?.settings.arguments as int,
                    ),
                NavigationRoutes.favourite.name: (context) =>
                    FavouriteMovieScreen(),
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
