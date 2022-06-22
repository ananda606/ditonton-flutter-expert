import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'search_tvseries_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late MockSearchTVSeries mockSearchTVSeries;
  late SearchTVSeriesBloc searchBloc;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    searchBloc = SearchTVSeriesBloc(mockSearchTVSeries);
  });

  final testTVEntity = TVSeries(
    backdropPath: '/path.jpg',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 9.9,
    posterPath: '/path.jpg',
    voteAverage: 9.9,
    voteCount: 1,
  );
  final tTvList = <TVSeries>[testTVEntity];
  const tQuery = 'gambit';

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTVSeriesEmpty());
  });

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'should emit [HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTVSeriesChange(tQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTVSeriesHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
      return OnQueryTVSeriesChange(tQuery).props;
    },
  );

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'should emit [Error] lwhen get search is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTVSeriesChange(tQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
      return SearchTVSeriesLoading().props;
    },
  );

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'should emit [empty] when get search is empty',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTVSeriesChange(tQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTVSeriesEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );
}
