part of 'movie_watchlist_bloc.dart';

@immutable
abstract class MovieWatchlistState extends Equatable {}

class MovieWatchlistInitial extends MovieWatchlistState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistLoading extends MovieWatchlistState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;

  MovieWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieIsAddedToWatchlist extends MovieWatchlistState {
  final bool isAdded;

  MovieIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class MovieWatchlistMessage extends MovieWatchlistState {
  final String message;

  MovieWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
