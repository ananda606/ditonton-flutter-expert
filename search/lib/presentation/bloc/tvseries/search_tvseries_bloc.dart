import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tvseries_event.dart';
part 'search_tvseries_state.dart';

class SearchTVSeriesBloc
    extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTVSeries _searchTVShows;

  SearchTVSeriesBloc(this._searchTVShows) : super(SearchTVSeriesEmpty()) {
    on<OnQueryTVSeriesChange>(_onQueryTVSeriesChange);
  }

  FutureOr<void> _onQueryTVSeriesChange(
      OnQueryTVSeriesChange event, Emitter<SearchTVSeriesState> emit) async {
    final query = event.query;
    emit(SearchTVSeriesEmpty());

    final result = await _searchTVShows.execute(query);

    result.fold(
      (failure) {
        emit(SearchTVSeriesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(SearchTVSeriesEmpty())
            : emit(SearchTVSeriesHasData(data));
      },
    );
  }

  @override
  Stream<SearchTVSeriesState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 200));
}
