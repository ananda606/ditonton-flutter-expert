import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvseries/tvseries.dart';

part 'tvseries_top_rated_event.dart';
part 'tvseries_top_rated_state.dart';

class TVSeriesTopRatedBloc
    extends Bloc<TVSeriesTopRatedEvent, TVSeriesTopRatedState> {
  final GetTopRatedTVSeries _getTopRatedTVShows;

  TVSeriesTopRatedBloc(
    this._getTopRatedTVShows,
  ) : super(TVSeriesTopRatedEmpty()) {
    on<OnTVSeriesTopRatedCalled>(_onTVSeriesTopRatedCalled);
  }

  FutureOr<void> _onTVSeriesTopRatedCalled(
    OnTVSeriesTopRatedCalled event,
    Emitter<TVSeriesTopRatedState> emit,
  ) async {
    emit(TVSeriesTopRatedLoading());

    final result = await _getTopRatedTVShows.execute();

    result.fold(
      (failure) {
        emit(TVSeriesTopRatedError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TVSeriesTopRatedEmpty())
            : emit(TVSeriesTopRatedHasData(data));
      },
    );
  }
}
