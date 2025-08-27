import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:fit_movies_app/data/db/local_database_service.dart';
import 'package:get/get.dart';

class FavouriteMovieController extends GetxController {
  final LocalDatabaseService dbService;

  FavouriteMovieController(this.dbService);

  final RxBool _isFavourite = false.obs;

  bool get isFavourite => _isFavourite.value;

  Future<void> findingFavouriteMovie(int movieId) async {
    final favouriteMovie = await dbService.isFavourite(movieId);
    if (favouriteMovie) {
      _isFavourite.value = true;
    } else {
      _isFavourite.value = false;
    }
  }

  void setFavouriteStatus(bool status) {
    _isFavourite.value = status;
  }

  Future<void> addFavouriteMovie(FavouriteMovie movie) async {
    await dbService.addFavouriteMovie(movie);
    _isFavourite.value = true;

    await getAllFavouriteMovies();
  }

  Future<void> removeFavouriteMovie(int movieId) async {
    await dbService.removeFavouriteMovie(movieId);
    _isFavourite.value = false;

    await getAllFavouriteMovies();
  }

  final Rx<List<FavouriteMovie>> _favouriteMovies =
      Rx<List<FavouriteMovie>>([]);

  List<FavouriteMovie> get favouriteMovies => _favouriteMovies.value;

  Future<void> getAllFavouriteMovies() async {
    _favouriteMovies.value = await dbService.getAllFavouriteMovies();
  }
}
