import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_movies_app/controllers/favourite_movie_controller/favourite_movie_controller.dart';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_filter.dart';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_list_controller.dart';
import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:fit_movies_app/data/firestore/firestore_movie_service.dart';
import 'package:fit_movies_app/widgets/favourite_movie_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteMovieScreen extends StatefulWidget {
  const FavouriteMovieScreen({super.key});

  @override
  State<FavouriteMovieScreen> createState() => _FavouriteMovieScreenState();
}

class _FavouriteMovieScreenState extends State<FavouriteMovieScreen> {
  FavouriteMovieController favouriteController =
      Get.put(FavouriteMovieController(Get.put(FirestoreMovieService())));

  MovieListController movieListController = Get.find();

  @override
  void initState() {
    Future.microtask(() {
      favouriteController.getAllFavouriteMovies();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> snapshots =
        favouriteController.streamAllFavouriteMovies();

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              movieListController.setFilter(MovieFilter.nowPlaying);
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Favourite Movies"),
        ),
        body: StreamFavouriteMovie(snapshots: snapshots));
  }
}

class FavouriteMovieContent extends StatelessWidget {
  final List<FavouriteMovie> favouriteMovies;
  const FavouriteMovieContent({super.key, required this.favouriteMovies});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return switch (favouriteMovies.isNotEmpty) {
        true => Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.7, // Adjust aspect ratio as needed
                ),
                itemCount: favouriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = favouriteMovies[index];

                  return FavouriteMovieItem(movie: movie);
                })),
        _ => const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No favourite movies")]),
          )
      };
    });
  }
}

class StreamFavouriteMovie extends StatefulWidget {
  final Stream<QuerySnapshot> snapshots;
  const StreamFavouriteMovie({super.key, required this.snapshots});

  @override
  State<StreamFavouriteMovie> createState() => _StreamFavouriteMovieState();
}

class _StreamFavouriteMovieState extends State<StreamFavouriteMovie> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final result = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7, // Adjust aspect ratio as needed
            ),
            itemCount: result.length,
            itemBuilder: (context, index) {
              final data = result[index].data() as FavouriteMovie;
              return FavouriteMovieItem(movie: data);
            },
          );
        });
  }
}
