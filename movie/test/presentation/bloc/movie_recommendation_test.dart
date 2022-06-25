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
  late MockGetMovieRecommendations mockGetMovieRecommend;
  late MovieRecommendationBloc movieBloc;

  const tId = 1;

  setUp(() {
    mockGetMovieRecommend = MockGetMovieRecommendations();
    movieBloc = MovieRecommendationBloc(mockGetMovieRecommend);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'emit loading and hasdata when data is success',
    build: () {
      when(mockGetMovieRecommend.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(MovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(testMovieList),
    ],
    verify: (blocAct) {
      verify(mockGetMovieRecommend.execute(tId));
      return MovieRecommendationCalled(tId).props;
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'emit loading and error when data is unsuccessful',
    build: () {
      when(mockGetMovieRecommend.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(MovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationError('Server Failure'),
    ],
    verify: (blocAct) => MovieRecommendationLoading(),
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'emit loading and empty when data is empty',
    build: () {
      when(mockGetMovieRecommend.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(MovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationEmpty(),
    ],
  );
}
