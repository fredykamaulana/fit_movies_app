import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_movies_app/data/model/favourite_movie.dart';

class FirestoreMovieService {
  final _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  late final _currentUserRef =
      FirebaseFirestore.instance.collection('users').doc(_currentUserId);

  late final _moviesRef = _currentUserRef
      .collection('favourite-movie')
      .withConverter<FavouriteMovie>(
        fromFirestore: (snapshots, _) =>
            FavouriteMovie.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Future addFavouriteMovie(FavouriteMovie movie) async {
    await _moviesRef.doc(movie.id.toString()).set(movie);
  }

  Future removeFavouriteMovie(int movieId) async {
    await _moviesRef.doc(movieId.toString()).delete();
  }

  Future<bool> isFavourite(int movieId) async {
    final result = await _moviesRef.doc(movieId.toString()).get();
    return result.exists;
  }

  Future<List<FavouriteMovie>> getAllFavouriteMovies() async {
    final dataSnapshot = await _moviesRef.get();

    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  //For real-time favourite movie list
  Stream<QuerySnapshot> getAllFavouriteMoviesRealTime() {
    return _moviesRef.snapshots();
  }
}
