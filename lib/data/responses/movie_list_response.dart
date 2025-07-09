class MovieListResponse {
  List<Result> results;

  MovieListResponse({required this.results});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      MovieListResponse(results: []);

  Map<String, dynamic> toJson() => {};
}

class Result {
  bool adult = false;
  String backdropPath = '';
  List<int> genreIds = [];
  int id = 0;
  String originalLanguage = '';
  String originalTitle = '';
  String overview = '';
  double popularity = 0;
  String posterPath = '';
  DateTime releaseDate = DateTime.now();
  String title = '';
  bool video = false;
  double voteAverage = 0;
  int voteCount = 0;

  Result();

  factory Result.fromJson(Map<String, dynamic> json) => Result();

  Map<String, dynamic> toJson() => {};
}
