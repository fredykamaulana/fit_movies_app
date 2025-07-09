class MovieDetailResponse {
  bool adult = false;
  String backdropPath = '';
  int budget = 0;
  List<Genre> genres = [];
  String homepage = '';
  int id = 0;
  String imdbId = '';
  List<String> originCountry = [];
  String originalLanguage = '';
  String originalTitle = '';
  String overview = '';
  double popularity = 0;
  String posterPath = '';
  List<ProductionCompany> productionCompanies = [];
  List<ProductionCountry> productionCountries = [];
  DateTime releaseDate = DateTime.now();
  int revenue = 0;
  int runtime = 0;
  List<SpokenLanguage> spokenLanguages = [];
  String status = '';
  String tagline = '';
  String title = '';
  bool video = false;
  double voteAverage = 0;
  int voteCount = 0;

  MovieDetailResponse();

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse();

  Map<String, dynamic> toJson() => {};
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"] ?? '',
        logoPath: json["logo_path"] ?? '',
        name: json["name"] ?? '',
        originCountry: json["origin_country"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"] ?? '',
        iso6391: json["iso_639_1"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
