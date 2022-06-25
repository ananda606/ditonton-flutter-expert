import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  MovieListBloc(
    this._getNowPlayingMovies,
  ) : super(MovieListEmpty()) {
    on<MovieListCalled>(_MovieListCalled);
  }

  FutureOr<void> _MovieListCalled(
      MovieListEvent event, Emitter<MovieListState> emit) async {
    emit(MovieListLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(MovieListError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(MovieListEmpty()) : emit(MovieListHasData(data));
      },
    );
  }
}
