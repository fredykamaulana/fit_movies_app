import 'package:fit_movies_app/data/network/http_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:flutter/foundation.dart';

class MovieService {
  final serviceName = '/movie';
  final http = HttpApiClient();

  Future<MovieListResponse> fetchMovies(String filter) async {
    try {
      if (kDebugMode) {
        print('$serviceName/$filter');
      }

      final response = await http.client.get(
          Uri.parse('${http.baseUrl}/$serviceName/$filter'),
          headers: http.headers);
      if (response.statusCode == 200) {
        return movieListResponseFromJson(response.body);
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to load movies: ${e.toString()}');
    }
  }

  Future<MovieDetailResponse> fetchMovieDetails(int movieId) async {
    try {
      final response = await http.client.get(
          Uri.parse('${http.baseUrl}/$serviceName/$movieId'),
          headers: http.headers);
      if (response.statusCode == 200) {
        return movieDetailResponseFromJson(response.body);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}
