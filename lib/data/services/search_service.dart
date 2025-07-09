import 'package:fit_movies_app/data/network/http_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:flutter/foundation.dart';

class SearchService {
  final http = HttpApiClient();
  final serviceName = 'search/movie';

  Future<MovieListResponse> searchMovies(String query) async {
    try {
      if (kDebugMode) {
        print('/search/movie?query=$query');
      }

      final response = await http.client.get(
          Uri.parse('${http.baseUrl}/search/movie?query=$query'),
          headers: http.headers);

      if (response.statusCode == 200) {
        return movieListResponseFromJson(response.body);
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
}
