import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies usecase;
  late MoviePopularBloc movieBloc;

  setUp(() {
    usecase = MockGetPopularMovies();
    movieBloc = MoviePopularBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, MoviePopularEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMoviePopularCalled()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnMoviePopularCalled().props;
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMoviePopularCalled()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularError('Server Failure'),
    ],
    verify: (bloc) => MoviePopularLoading(),
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMoviePopularCalled()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularEmpty(),
    ],
  );
}
