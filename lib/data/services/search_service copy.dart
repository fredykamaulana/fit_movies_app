import 'package:fit_movies_app/data/network/http_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:flutter/foundation.dart';

class SearchService {
  final http = HttpApiClient();
  final serviceName = 'search/movie';

  Future<MovieListResponse> searchMovies(String query, int page) async {
    try {
      if (kDebugMode) {
        print('/search/movie?query=$query&page=$page');
      }

      final response = await http.client.get(
          Uri.parse('${http.baseUrl}/search/movie?query=$query&page=$page'),
          headers: http.headers);

      if (response.statusCode == 200) {
        return MovieListResponse.fromJson({});
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
}
