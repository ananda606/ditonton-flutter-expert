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
  late MockGetOnAirTVSeries usecase;
  late TVSeriesListBloc tvBloc;

  setUp(() {
    usecase = MockGetOnAirTVSeries();
    tvBloc = TVSeriesListBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TVSeriesListEmpty());
  });

  blocTest<TVSeriesListBloc, TVSeriesListState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTVSeriesList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesListCalled()),
    expect: () => [
      TVSeriesListLoading(),
      TVSeriesListHasData(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnTVSeriesListCalled().props;
    },
  );

  blocTest<TVSeriesListBloc, TVSeriesListState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesListCalled()),
    expect: () => [
      TVSeriesListLoading(),
      TVSeriesListError('Server Failure'),
    ],
    verify: (bloc) => TVSeriesListLoading(),
  );

  blocTest<TVSeriesListBloc, TVSeriesListState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesListCalled()),
    expect: () => [
      TVSeriesListLoading(),
      TVSeriesListEmpty(),
    ],
  );
}
