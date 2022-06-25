import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, MovieTopRatedEmpty());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'emit loading and hasdata when data is success',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(MovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedHasData(testMovieList),
    ],
    verify: (blocAct) {
      verify(mockGetTopRatedMovies.execute());
      return MovieTopRatedCalled().props;
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'emit loading and error when data is unsuccess',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(MovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedError('Server Failure'),
    ],
    verify: (blocAct) => MovieTopRatedLoading(),
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'emit loading and empty when data is empty',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(MovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedEmpty(),
    ],
  );
}
