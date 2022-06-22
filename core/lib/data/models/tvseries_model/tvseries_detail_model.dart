import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetailModel extends Equatable {
  TVSeriesDetailModel({
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.adult,
    required this.backdropPath,
    required this.episodeRuntime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.lastAirDate,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final String lastAirDate;
  final String name;
  final bool adult;
  final String? backdropPath;
  final List<int> episodeRuntime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final double voteAverage;
  final int voteCount;

  factory TVSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TVSeriesDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        episodeRuntime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        lastAirDate: json["last_air_date"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "episode_run_time": List<dynamic>.from(episodeRuntime.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
        adult: this.adult,
        backdropPath: this.backdropPath,
        episodeRuntime: this.episodeRuntime,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        lastAirDate: this.lastAirDate,
        name: this.name,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originalName: this.originalName,
        overview: this.overview,
        posterPath: this.posterPath,
        seasons: this.seasons.map((season) => season.toEntity()).toList(),
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }

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

class SeasonModel extends Equatable {
  SeasonModel({
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

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Seasons toEntity() {
    return Seasons(
      airDate: this.airDate,
      episodeCount: this.episodeCount,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

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
