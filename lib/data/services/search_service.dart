import 'package:fit_movies_app/data/network/dio_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:flutter/foundation.dart';

class SearchService {
  Future<RemoteState> searchMovies(String query, int page) async {
    if (kDebugMode) {
      print('/search/movie?query=$query&page=$page');
    }

    final response = await DioApiClient()
        .dio
        .get('/search/movie', queryParameters: {'query': query, 'page': page});

    return RemoteStateSuccess<MovieListResponse>(
        MovieListResponse.fromJson(response.data));
  }
}
