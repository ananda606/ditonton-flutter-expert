part of 'tvseries_watchlist_bloc.dart';

@immutable
abstract class TVSeriesWatchlistState extends Equatable {}

class TVSeriesWatchlistInitial extends TVSeriesWatchlistState {
  @override
  List<Object> get props => [];
}

class TVSeriesWatchlistEmpty extends TVSeriesWatchlistState {
  @override
  List<Object> get props => [];
}

class TVSeriesWatchlistLoading extends TVSeriesWatchlistState {
  @override
  List<Object> get props => [];
}

class TVSeriesWatchlistError extends TVSeriesWatchlistState {
  final String message;

  TVSeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesWatchlistHasData extends TVSeriesWatchlistState {
  final List<TVSeries> result;

  TVSeriesWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TVSeriesIsAddedToWatchlist extends TVSeriesWatchlistState {
  final bool isAdded;

  TVSeriesIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TVSeriesWatchlistMessage extends TVSeriesWatchlistState {
  final String message;

  TVSeriesWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
