import 'package:fit_movies_app/data/network/http_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';

class MovieService {
  final serviceName = '/movie';
  final http = HttpApiClient();

  Future<MovieListResponse> fetchMovies(String filter) async {
    return MovieListResponse(results: []);
  }

  Future<MovieDetailResponse> fetchMovieDetails(int movieId) async {
    return MovieDetailResponse();
  }
}
