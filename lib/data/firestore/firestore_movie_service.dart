import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_movies_app/data/model/favourite_movie.dart';

class FirestoreMovieService {
  Future addFavouriteMovie(FavouriteMovie movie) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    late final currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    late final moviesRef = currentUserRef
        .collection('favourite-movie')
        .withConverter<FavouriteMovie>(
          fromFirestore: (snapshots, _) =>
              FavouriteMovie.fromJson(snapshots.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

    await moviesRef.doc(movie.id.toString()).set(movie);
  }

  Future removeFavouriteMovie(int movieId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    late final currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    late final moviesRef = currentUserRef
        .collection('favourite-movie')
        .withConverter<FavouriteMovie>(
          fromFirestore: (snapshots, _) =>
              FavouriteMovie.fromJson(snapshots.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

    await moviesRef.doc(movieId.toString()).delete();
  }

  Future<bool> isFavourite(int movieId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    late final currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    late final moviesRef = currentUserRef
        .collection('favourite-movie')
        .withConverter<FavouriteMovie>(
          fromFirestore: (snapshots, _) =>
              FavouriteMovie.fromJson(snapshots.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

    final result = await moviesRef.doc(movieId.toString()).get();
    return result.exists;
  }

  Future<List<FavouriteMovie>> getAllFavouriteMovies() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    late final currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    late final moviesRef = currentUserRef
        .collection('favourite-movie')
        .withConverter<FavouriteMovie>(
          fromFirestore: (snapshots, _) =>
              FavouriteMovie.fromJson(snapshots.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

    final dataSnapshot = await moviesRef.get();

    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  //For real-time favourite movie list
  Stream<QuerySnapshot> getAllFavouriteMoviesRealTime() {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    late final currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    late final moviesRef = currentUserRef
        .collection('favourite-movie')
        .withConverter<FavouriteMovie>(
          fromFirestore: (snapshots, _) =>
              FavouriteMovie.fromJson(snapshots.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

    return moviesRef.snapshots();
  }
}
