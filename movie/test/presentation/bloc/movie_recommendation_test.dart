import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
])
void main() {
  late MockGetMovieRecommendations usecase;
  late MovieRecommendationBloc movieBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetMovieRecommendations();
    movieBloc = MovieRecommendationBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return OnMovieRecommendationCalled(tId).props;
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationError('Server Failure'),
    ],
    verify: (bloc) => MovieRecommendationLoading(),
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationEmpty(),
    ],
  );
}
