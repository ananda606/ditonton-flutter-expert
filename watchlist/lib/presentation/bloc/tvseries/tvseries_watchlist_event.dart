part of 'tvseries_watchlist_bloc.dart';

@immutable
abstract class TVSeriesWatchlistEvent extends Equatable {}

class OnFetchTVSeriesWatchlist extends TVSeriesWatchlistEvent {
  @override
  List<Object> get props => [];
}

class FetchTVSeriesWatchlistStatus extends TVSeriesWatchlistEvent {
  final int id;

  FetchTVSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTVSeriesToWatchlist extends TVSeriesWatchlistEvent {
  final TVSeriesDetail tv;

  AddTVSeriesToWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTVSeriesFromWatchlist extends TVSeriesWatchlistEvent {
  final TVSeriesDetail tv;

  RemoveTVSeriesFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}
