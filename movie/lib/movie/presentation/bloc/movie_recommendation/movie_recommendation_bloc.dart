import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationBloc(this._getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<MovieRecommendationCalled>(_MovieRecommendationCalled);
  }

  FutureOr<void> _MovieRecommendationCalled(
    MovieRecommendationCalled event,
    Emitter<MovieRecommendationState> emit,
  ) async {
    final id = event.id;
    emit(MovieRecommendationLoading());
    final result = await _getMovieRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(MovieRecommendationError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(MovieRecommendationEmpty())
            : emit(MovieRecommendationHasData(data));
      },
    );
  }
}
