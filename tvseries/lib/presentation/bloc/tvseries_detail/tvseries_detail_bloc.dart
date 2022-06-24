import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/tvseries/tvseries_detail.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tvseries/tvseries.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final GetTVSeriesDetail _getTVSeriesDetail;

  TVSeriesDetailBloc(
    this._getTVSeriesDetail,
  ) : super(TVSeriesDetailEmpty()) {
    on<OnTVSeriesDetailCalled>(_onTVSeriesDetailCalled);
  }

  FutureOr<void> _onTVSeriesDetailCalled(
    OnTVSeriesDetailCalled event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    final id = event.id;
    emit(TVSeriesDetailLoading());

    final result = await _getTVSeriesDetail.execute(id);

    result.fold(
      (failure) {
        emit(TVSeriesDetailError(failure.message));
      },
      (data) {
        emit(TVSeriesDetailHasData(data));
      },
    );
  }
}
