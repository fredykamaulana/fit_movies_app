import 'package:fit_movies_app/data/network/dio_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:flutter/foundation.dart';

class MovieService {
  final serviceName = '/movie';

  Future<RemoteState> fetchMovies(String filter, int page) async {
    if (kDebugMode) {
      print('$serviceName/$filter?page=$page');
    }

    final response =
        await DioApiClient().dio.get('$serviceName/$filter?page=$page');

    return RemoteStateSuccess<MovieListResponse>(
        MovieListResponse.fromJson(response.data));
  }

  Future<RemoteState> fetchMovieDetails(int movieId) async {
    final response = await DioApiClient().dio.get('$serviceName/$movieId');

    return RemoteStateSuccess<MovieDetailResponse>(
        MovieDetailResponse.fromJson(response.data));
  }
}
