import 'package:core/domain/entities/movie/genre.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  const TVSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.episodeRuntime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> episodeRuntime;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final String? posterPath;
  final List<Seasons> seasons;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRuntime,
        firstAirDate,
        genres,
        id,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        posterPath,
        seasons,
        voteAverage,
        voteCount,
      ];
}

class Seasons extends Equatable {
  const Seasons({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
