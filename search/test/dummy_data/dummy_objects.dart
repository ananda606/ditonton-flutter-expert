import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVSeries = TVSeries(
  backdropPath: '/q8eejQcg1bAqImEV8jh8RtBD4uH.jpg',
  firstAirDate: '2021-11-06',
  genreIds: [
    16,
    10765,
    10759,
    18,
  ],
  id: 94605,
  name: 'Arcane',
  originalName: 'Arcane',
  overview:
      'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
  popularity: 218.007,
  posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
  voteAverage: 9.1,
  voteCount: 1869,
);

final testTVSeriesList = [testTVSeries];

final testTVSeriesDetail = TVSeriesDetail(
  adult: false,
  backdropPath: '/path.jpg',
  episodeRuntime: [60],
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  lastAirDate: 'lastAirDate',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: '/path.jpg',
  seasons: [
    Seasons(
      airDate: 'airDate',
      episodeCount: 12,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistTVSeries = TVSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

final testTVSeriesTable = TVSeriesTable(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

final testTVSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': '/path.jpg',
  'name': 'name',
};
