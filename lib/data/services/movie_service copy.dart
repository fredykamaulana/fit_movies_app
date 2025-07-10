import 'package:fit_movies_app/data/network/dio_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:flutter/foundation.dart';

class MovieService {
  final serviceName = '/movie';

  Future<RemoteState> fetchMovies(String filter, int page) async {
    try {
      if (kDebugMode) {
        print('$serviceName/$filter?page=$page');
      }

      final response =
          await DioApiClient().dio.get('$serviceName/$filter?page=$page');
      if (response.statusCode == 200) {
        return RemoteStateSuccess<MovieListResponse>(
            MovieListResponse.fromJson(response.data));
      } else {
        return RemoteStateError('${response.statusMessage}');
        //throw Exception('Failed to load movies');
      }
    } catch (e) {
      return RemoteStateError(e.toString());
      //throw Exception('Failed to load movies: ${e.toString()}');
    }
  }

  Future<RemoteState> fetchMovieDetails(int movieId) async {
    try {
      final response = await DioApiClient().dio.get('$serviceName/$movieId');
      if (response.statusCode == 200) {
        return RemoteStateSuccess<MovieDetailResponse>(
            MovieDetailResponse.fromJson(response.data));
      } else {
        return RemoteStateError('${response.statusMessage}');
        //throw Exception('Failed to load movie details');
      }
    } catch (e) {
      return RemoteStateError(e.toString());
      //throw Exception('Failed to load movie details: $e');
    }
  }
}
