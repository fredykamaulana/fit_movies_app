import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';

List<Result> dummyMovies = [
  Result(
      adult: false,
      backdropPath: '/iZLqwEwUViJdSkGVjePGhxYzbDb.jpg',
      genreIds: [],
      id: 123,
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 0.0,
      posterPath: '/yvirUYrva23IudARHn3mMGVxWqM.jp',
      releaseDate: DateTime.now(),
      title: 'title',
      video: false,
      voteAverage: 0.0,
      voteCount: 123),
  Result(
      adult: false,
      backdropPath: '/iZLqwEwUViJdSkGVjePGhxYzbDb.jpg',
      genreIds: [],
      id: 123,
      originalLanguage: 'originalLanguage 2',
      originalTitle: 'originalTitle 2',
      overview: 'overview',
      popularity: 0.0,
      posterPath: '/yvirUYrva23IudARHn3mMGVxWqM.jp',
      releaseDate: DateTime.now(),
      title: 'title 2',
      video: false,
      voteAverage: 0.0,
      voteCount: 123)
];

MovieListResponse dummyMovieListResponse({List<Result> movies = const []}) =>
    MovieListResponse(
      page: 1,
      results: movies,
      totalResults: 0,
      totalPages: 0,
    );

MovieDetailResponse dummyMovieDetailResponse = MovieDetailResponse(
  adult: false,
  backdropPath: '/iZLqwEwUViJdSkGVjePGhxYzbDb.jpg',
  genres: [
    Genre(id: 1, name: 'Action'),
    Genre(id: 2, name: 'Drama'),
  ],
  homepage: 'homepage',
  id: 123,
  imdbId: 'imdbId',
  originalLanguage: 'originalLanguage',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 0.0,
  posterPath: '/yvirUYrva23IudARHn3mMGVxWqM.jp',
  releaseDate: DateTime.now(),
  runtime: 120,
  status: 'status',
  tagline: 'tagline',
  title: 'title',
  video: false,
  voteAverage: 0.0,
  voteCount: 123,
  budget: 0,
  revenue: 0,
  productionCompanies: [
    ProductionCompany(
        id: 1,
        logoPath: 'logoPath',
        name: 'companyName',
        originCountry: 'originCountry'),
    ProductionCompany(
        id: 2,
        logoPath: 'logoPath 2',
        name: 'companyName 2',
        originCountry: 'originCountry 2'),
  ],
  productionCountries: [
    ProductionCountry(iso31661: 'US', name: 'United States of America'),
    ProductionCountry(iso31661: 'ID', name: 'Indonesia'),
  ],
  spokenLanguages: [
    SpokenLanguage(englishName: 'English', iso6391: 'en', name: 'English'),
    SpokenLanguage(englishName: 'Indonesian', iso6391: 'id', name: 'Bahasa'),
  ],
  originCountry: [
    'US',
    'ID',
  ],
);

FavouriteMovie dummyFavouriteMovie = FavouriteMovie(
  id: 123,
  title: 'title',
  posterPath: 'posterPath',
  releaseDate: '2023-10-01',
);
