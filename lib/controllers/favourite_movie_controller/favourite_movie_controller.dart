import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_movies_app/data/model/favourite_movie.dart';
import 'package:fit_movies_app/data/firestore/firestore_movie_service.dart';
import 'package:get/get.dart';

class FavouriteMovieController extends GetxController {
  final FirestoreMovieService dbService;

  FavouriteMovieController(this.dbService);

  final RxBool _isFavourite = false.obs;

  get isFavourite => _isFavourite.value;

  findingFavouriteMovie(int movieId) async {
    final favouriteMovie = await dbService.isFavourite(movieId);
    if (favouriteMovie) {
      _isFavourite.value = true;
    } else {
      _isFavourite.value = false;
    }
  }

  setFavouriteStatus(bool status) {
    _isFavourite.value = status;
  }

  Future addFavouriteMovie(FavouriteMovie movie) async {
    await dbService.addFavouriteMovie(movie);
    _isFavourite.value = true;

    await getAllFavouriteMovies();
  }

  Future removeFavouriteMovie(int movieId) async {
    await dbService.removeFavouriteMovie(movieId);
    _isFavourite.value = false;

    await getAllFavouriteMovies();
  }

  final Rx<List<FavouriteMovie>> _favouriteMovies =
      Rx<List<FavouriteMovie>>([]);

  get favouriteMovies => _favouriteMovies.value;

  getAllFavouriteMovies() async {
    _favouriteMovies.value = await dbService.getAllFavouriteMovies();
  }

  Stream<QuerySnapshot> streamAllFavouriteMovies() {
    final snapshots = dbService.getAllFavouriteMoviesRealTime();
    return snapshots;
  }
}
