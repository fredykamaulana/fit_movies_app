import 'package:fit_movies_app/controllers/movie_list_controller/movie_filter.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:fit_movies_app/data/services/movie_service.dart';
import 'package:fit_movies_app/data/services/search_service.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:get/get.dart';

class MovieListController extends GetxController {
  final MovieService movieService;

  MovieListController({required this.movieService});

  final SearchService searchService = Get.put(SearchService());

  final Rx<RemoteState> _remoteState = Rx<RemoteState>(RemoteStateNone());

  get remoteState => _remoteState.value;

  final Rx<List<Result>> _movieList = Rx<List<Result>>([]);

  get movieList => _movieList.value;

  Future<List<Result>> getMovieList(String filter) async {
    try {
      if (_remoteState.value is RemoteStateLoading) {
        return _movieList.value; // Return current list if already loading
      }

      _remoteState.value = RemoteStateLoading();

      final result = await movieService.fetchMovies(filter);

      if (result.results.isEmpty) {
        _remoteState.value = RemoteStateError('No more movies found');
      } else {
        _remoteState.value = RemoteStateSuccess<MovieListResponse>(result);
        _movieList.value = result.results;
      }

      return result.results;
    } on Exception catch (e) {
      _remoteState.value = RemoteStateError(e.toString());
      rethrow;
    }
  }

  /// **
  /// Filter movie business logic ##############################################
  /// **

  final RxString _selectedFilter = MovieFilter.nowPlaying.name.obs;

  get selectedFilter => _selectedFilter.value;

  setFilter(MovieFilter filter) {
    if (_selectedFilter.value != filter.name) {
      if (!filter.name.contains('@')) {
        _movieList.value = [];
        _remoteState.value = RemoteStateNone();
        getMovieList(filter.name);
      }
      _selectedFilter.value = filter.name;
    }
  }

  /// **
  /// Search business logic ####################################################
  /// **

  final RxBool _isSearching = false.obs;

  get isSearching => _isSearching.value;

  setIsSearching(bool value) {
    _isSearching.value = value;
    if (!value) {
      _searchQuery.value = '';
      _movieList.value = [];
      _remoteState.value = RemoteStateNone();
      getMovieList(_selectedFilter.value);
    }
  }

  final RxString _searchQuery = ''.obs;

  get searchQuery => _searchQuery.value;

  setSearchQuery(String query) {
    _searchQuery.value = query;
  }

  Future<List<Result>> searchMovie(String query) async {
    try {
      if (_remoteState.value is RemoteStateLoading) {
        return _movieList.value; // Return current list if already loading
      }

      _remoteState.value = RemoteStateLoading();

      final result = await searchService.searchMovies(query);

      if (result.results.isEmpty) {
        _remoteState.value = RemoteStateError('No more movies found');
      } else {
        _remoteState.value = RemoteStateSuccess<MovieListResponse>(result);
        _movieList.value = result.results;
      }

      return result.results;
    } on Exception catch (e) {
      _remoteState.value = RemoteStateError(e.toString());
      rethrow;
    }
  }
}
