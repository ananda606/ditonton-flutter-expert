import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tvseries_recommendation_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesRecommendations,
])
void main() {
  late MockGetTVSeriesRecommendations mockGetRecommmend;
  late TVSeriesRecommendationBloc tvseriesBloc;

  const tId = 1;

  setUp(() {
    mockGetRecommmend = MockGetTVSeriesRecommendations();
    tvseriesBloc = TVSeriesRecommendationBloc(mockGetRecommmend);
  });

  test('initial state should be empty', () {
    expect(tvseriesBloc.state, TVSeriesRecommendationEmpty());
  });

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
    'emit loading and hasdata when success',
    build: () {
      when(mockGetRecommmend.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesRecommendationCalled(tId)),
    expect: () => [
      TVSeriesRecommendationLoading(),
      TVSeriesRecommendationHasData(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetRecommmend.execute(tId));
      return OnTVSeriesRecommendationCalled(tId).props;
    },
  );

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
    'emit loading and error when unsuccess',
    build: () {
      when(mockGetRecommmend.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesRecommendationCalled(tId)),
    expect: () => [
      TVSeriesRecommendationLoading(),
      TVSeriesRecommendationError('Server Failure'),
    ],
    verify: (bloc) => TVSeriesRecommendationLoading(),
  );

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(mockGetRecommmend.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesRecommendationCalled(tId)),
    expect: () => [
      TVSeriesRecommendationLoading(),
      TVSeriesRecommendationEmpty(),
    ],
  );
}
