import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tvseries/tvseries.dart';
import 'package:core/domain/entities/tvseries/tvseries_detail.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:watchlist/watchlist.dart';

part 'tvseries_watchlist_event.dart';
part 'tvseries_watchlist_state.dart';

class TVSeriesWatchlistBloc
    extends Bloc<TVSeriesWatchlistEvent, TVSeriesWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTVSeries _getWatchlistTVShows;
  final GetWatchlistTVSeriesStatus _getWatchlistTVStatus;
  final RemoveWatchlistTVSeries _removeTVSeriesWatchlist;
  final SaveWatchlistTVSeries _saveTVWatchList;

  TVSeriesWatchlistBloc(
    this._getWatchlistTVShows,
    this._getWatchlistTVStatus,
    this._saveTVWatchList,
    this._removeTVSeriesWatchlist,
  ) : super(TVSeriesWatchlistInitial()) {
    on<OnFetchTVSeriesWatchlist>(_onFetchTVSeriesWatchlist);
    on<FetchTVSeriesWatchlistStatus>(_fetchTVSeriesWatchlistStatus);
    on<AddTVSeriesToWatchlist>(_addTVSeriesToWatchlist);
    on<RemoveTVSeriesFromWatchlist>(_remoteTVSeriesFromWatchlist);
  }

  FutureOr<void> _onFetchTVSeriesWatchlist(
    OnFetchTVSeriesWatchlist event,
    Emitter<TVSeriesWatchlistState> emit,
  ) async {
    emit(TVSeriesWatchlistLoading());

    final result = await _getWatchlistTVShows.execute();

    result.fold(
      (failure) {
        emit(TVSeriesWatchlistError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TVSeriesWatchlistEmpty())
            : emit(TVSeriesWatchlistHasData(data));
      },
    );
  }

  FutureOr<void> _fetchTVSeriesWatchlistStatus(
    FetchTVSeriesWatchlistStatus event,
    Emitter<TVSeriesWatchlistState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistTVStatus.execute(id);

    emit(TVSeriesIsAddedToWatchlist(result));
  }

  FutureOr<void> _addTVSeriesToWatchlist(
    AddTVSeriesToWatchlist event,
    Emitter<TVSeriesWatchlistState> emit,
  ) async {
    final tv = event.tv;

    final result = await _saveTVWatchList.execute(tv);

    result.fold(
      (failure) {
        emit(TVSeriesWatchlistError(failure.message));
      },
      (message) {
        emit(TVSeriesWatchlistMessage(message));
      },
    );
  }

  FutureOr<void> _remoteTVSeriesFromWatchlist(
    RemoveTVSeriesFromWatchlist event,
    Emitter<TVSeriesWatchlistState> emit,
  ) async {
    final tv = event.tv;

    final result = await _removeTVSeriesWatchlist.execute(tv);

    result.fold(
      (failure) {
        emit(TVSeriesWatchlistError(failure.message));
      },
      (message) {
        emit(TVSeriesWatchlistMessage(message));
      },
    );
  }
}
