import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovie;
  late MovieListBloc movieBloc;

  setUp(() {
    mockGetNowPlayingMovie = MockGetNowPlayingMovies();
    movieBloc = MovieListBloc(mockGetNowPlayingMovie);
  });

  test('initial state  empty', () {
    expect(movieBloc.state, MovieListEmpty());
  });

  blocTest<MovieListBloc, MovieListState>(
    'when data success emit loading and hasdata state',
    build: () {
      when(mockGetNowPlayingMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (bloc) => bloc.add(MovieListCalled()),
    expect: () => [
      MovieListLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovie.execute());
      return MovieListCalled().props;
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'when data unsuccess emit loading and error state',
    build: () {
      when(mockGetNowPlayingMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (bloc) => bloc.add(MovieListCalled()),
    expect: () => [
      MovieListLoading(),
      MovieListError('Server Failure'),
    ],
    verify: (bloc) => MovieListLoading(),
  );

  blocTest<MovieListBloc, MovieListState>(
    'emit empty when data is empty',
    build: () {
      when(mockGetNowPlayingMovie.execute())
          .thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(MovieListCalled()),
    expect: () => [
      MovieListLoading(),
      MovieListEmpty(),
    ],
  );
}
