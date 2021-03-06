import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<MovieDetailCalled>(_MovieDetailCalled);
  }

  // ignore: non_constant_identifier_names
  FutureOr<void> _MovieDetailCalled(
    MovieDetailCalled movieDetailEvent,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());

    final result = await _getMovieDetail.execute(movieDetailEvent.id);

    result.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (data) {
        emit(MovieDetailHasData(data));
      },
    );
  }
}
