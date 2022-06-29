import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(MoviePopularEmpty()) {
    on<MoviePopularCalled>(_MoviePopularCalled);
  }

  // ignore: non_constant_identifier_names
  FutureOr<void> _MoviePopularCalled(
    MoviePopularCalled event,
    Emitter<MoviePopularState> emit,
  ) async {
    emit(MoviePopularLoading());

    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(MoviePopularError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(MoviePopularEmpty())
            : emit(MoviePopularHasData(data));
      },
    );
  }
}
