import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tvseries/tvseries.dart';

part 'tvseries_popular_event.dart';
part 'tvseries_popular_state.dart';

class TVSeriesPopularBloc
    extends Bloc<TVSeriesPopularEvent, TVSeriesPopularState> {
  final GetPopularTVSeries _getPopularTVShows;

  TVSeriesPopularBloc(
    this._getPopularTVShows,
  ) : super(TVSeriesPopularEmpty()) {
    on<OnTVSeriesPopularCalled>(_onTVSeriesPopularCalled);
  }

  FutureOr<void> _onTVSeriesPopularCalled(
    OnTVSeriesPopularCalled event,
    Emitter<TVSeriesPopularState> emit,
  ) async {
    emit(TVSeriesPopularLoading());

    final result = await _getPopularTVShows.execute();

    result.fold(
      (failure) {
        emit(TVSeriesPopularError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TVSeriesPopularEmpty())
            : emit(TVSeriesPopularHasData(data));
      },
    );
  }
}
