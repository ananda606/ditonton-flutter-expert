part of 'movie_watchlist_bloc.dart';

@immutable
abstract class MovieWatchlistEvent extends Equatable {}

class OnFetchMovieWatchlist extends MovieWatchlistEvent {
  @override
  List<Object> get props => [];
}

class FetchWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieToWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  AddMovieToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieFromWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  RemoveMovieFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}
