import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetOnAirTVSeries,
  GetPopularTVSeries,
  GetTopRatedTVSeries,
])
void main() {
  late MockGetOnAirTVSeries mockGetOnAirTVSeries;
  late TVSeriesListBloc tvBloc;

  setUp(() {
    mockGetOnAirTVSeries = MockGetOnAirTVSeries();
    tvBloc = TVSeriesListBloc(mockGetOnAirTVSeries);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TVSeriesListEmpty());
  });

  blocTest<TVSeriesListBloc, TVSeriesListState>(
    'emit loading and hasdata when success',
    build: () {
      when(mockGetOnAirTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvBloc;
    },
    act: (blocAct) => blocAct.add(OnTVSeriesListCalled()),
    expect: () => [
      TVSeriesListLoading(),
      TVSeriesListHasData(testTVSeriesList),
    ],
    verify: (blocAct) {
      verify(mockGetOnAirTVSeries.execute());
      return OnTVSeriesListCalled().props;
    },
  );

  blocTest<TVSeriesListBloc, TVSeriesListState>(
    'emit loading and error when unsuccess',
    build: () {
      when(mockGetOnAirTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (blocAct) => blocAct.add(OnTVSeriesListCalled()),
    expect: () => [
      TVSeriesListLoading(),
      TVSeriesListError('Server Failure'),
    ],
    verify: (blocAct) => TVSeriesListLoading(),
  );

  blocTest<TVSeriesListBloc, TVSeriesListState>(
    'emit loading and empty when unsuccess',
    build: () {
      when(mockGetOnAirTVSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (blocAct) => blocAct.add(OnTVSeriesListCalled()),
    expect: () => [
      TVSeriesListLoading(),
      TVSeriesListEmpty(),
    ],
  );
}
