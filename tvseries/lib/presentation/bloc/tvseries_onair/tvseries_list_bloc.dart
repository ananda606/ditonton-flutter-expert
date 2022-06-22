import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvseries/tvseries.dart';

part 'tvseries_list_event.dart';
part 'tvseries_list_state.dart';

class TVSeriesListBloc extends Bloc<TVSeriesListEvent, TVSeriesListState> {
  final GetOnAirTVSeries _getOnAirTVSeries;

  TVSeriesListBloc(this._getOnAirTVSeries) : super(TVSeriesListEmpty()) {
    on<OnTVSeriesListCalled>(_onTVSeriesListCalled);
  }

  FutureOr<void> _onTVSeriesListCalled(
      OnTVSeriesListCalled event, Emitter<TVSeriesListState> emit) async {
    emit(TVSeriesListLoading());

    final result = await _getOnAirTVSeries.execute();

    result.fold(
      (failure) {
        emit(TVSeriesListError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TVSeriesListEmpty())
            : emit(TVSeriesListHasData(data));
      },
    );
  }
}
