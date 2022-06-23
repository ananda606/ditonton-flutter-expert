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
  late MockGetTVSeriesRecommendations usecase;
  late TVSeriesRecommendationBloc tvBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetTVSeriesRecommendations();
    tvBloc = TVSeriesRecommendationBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TVSeriesRecommendationEmpty());
  });

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesRecommendationCalled(tId)),
    expect: () => [
      TVSeriesRecommendationLoading(),
      TVSeriesRecommendationHasData(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return OnTVSeriesRecommendationCalled(tId).props;
    },
  );

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvBloc;
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
      when(usecase.execute(tId)).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesRecommendationCalled(tId)),
    expect: () => [
      TVSeriesRecommendationLoading(),
      TVSeriesRecommendationEmpty(),
    ],
  );
}
