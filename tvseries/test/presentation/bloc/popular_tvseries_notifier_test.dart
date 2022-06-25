import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late TVSeriesPopularBloc tvBloc;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    tvBloc = TVSeriesPopularBloc(mockGetPopularTVSeries);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TVSeriesPopularEmpty());
  });

  blocTest<TVSeriesPopularBloc, TVSeriesPopularState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesPopularCalled()),
    expect: () => [
      TVSeriesPopularLoading(),
      TVSeriesPopularHasData(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVSeries.execute());
      return OnTVSeriesPopularCalled().props;
    },
  );

  blocTest<TVSeriesPopularBloc, TVSeriesPopularState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesPopularCalled()),
    expect: () => [
      TVSeriesPopularLoading(),
      TVSeriesPopularError('Server Failure'),
    ],
    verify: (bloc) => TVSeriesPopularLoading(),
  );

  blocTest<TVSeriesPopularBloc, TVSeriesPopularState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesPopularCalled()),
    expect: () => [
      TVSeriesPopularLoading(),
      TVSeriesPopularEmpty(),
    ],
  );
}
