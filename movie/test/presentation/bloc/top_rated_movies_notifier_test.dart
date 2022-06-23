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
  late MockGetTopRatedMovies usecase;
  late MovieTopRatedBloc movieBloc;

  setUp(() {
    usecase = MockGetTopRatedMovies();
    movieBloc = MovieTopRatedBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, MovieTopRatedEmpty());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnMovieTopRatedCalled().props;
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedError('Server Failure'),
    ],
    verify: (bloc) => MovieTopRatedLoading(),
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedEmpty(),
    ],
  );
}
