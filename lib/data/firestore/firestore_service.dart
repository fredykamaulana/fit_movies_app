import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_movies_app/data/db/favourite_movie.dart';

class FirestoreService {
  final moviesRef = FirebaseFirestore.instance
      .collection('favourite-movie')
      .withConverter<FavouriteMovie>(
        fromFirestore: (snapshots, _) =>
            FavouriteMovie.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Future addFavouriteMovie(FavouriteMovie movie) async {
    await moviesRef.doc(movie.id.toString()).set(movie);
  }

  Future removeFavouriteMovie(int movieId) async {
    await moviesRef.doc(movieId.toString()).delete();
  }

  Future<bool> isFavourite(int movieId) async {
    final result = await moviesRef.doc(movieId.toString()).get();
    return result.exists;
  }

  Future<List<FavouriteMovie>> getAllFavouriteMovies() async {
    final dataSnapshot = await moviesRef.get();

    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  //For real-time favourite movie list
  Future<Stream<QuerySnapshot>> getAllFavouriteMoviesRealTime() async {
    return moviesRef.snapshots();
  }
}
