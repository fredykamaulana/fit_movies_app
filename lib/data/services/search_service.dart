import 'package:fit_movies_app/data/network/http_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';

class SearchService {
  final http = HttpApiClient();
  final serviceName = 'search/movie';

  Future<MovieListResponse> searchMovies(String query) async {
    return MovieListResponse(results: []);
  }
}
