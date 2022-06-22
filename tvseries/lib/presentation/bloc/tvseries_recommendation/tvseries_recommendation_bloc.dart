import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvseries/tvseries.dart';

part 'tvseries_recommendation_event.dart';
part 'tvseries_recommendation_state.dart';

class TVSeriesRecommendationBloc
    extends Bloc<TVSeriesRecommendationEvent, TVSeriesRecommendationState> {
  final GetTVSeriesRecommendations _getTVRecommendations;

  TVSeriesRecommendationBloc(this._getTVRecommendations)
      : super(TVSeriesRecommendationEmpty()) {
    on<OnTVSeriesRecommendationCalled>(_onTVSeriesRecommendationCalled);
  }

  FutureOr<void> _onTVSeriesRecommendationCalled(
    OnTVSeriesRecommendationCalled event,
    Emitter<TVSeriesRecommendationState> emit,
  ) async {
    final id = event.id;
    emit(TVSeriesRecommendationLoading());

    final result = await _getTVRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(TVSeriesRecommendationError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TVSeriesRecommendationEmpty())
            : emit(TVSeriesRecommendationHasData(data));
      },
    );
  }
}
