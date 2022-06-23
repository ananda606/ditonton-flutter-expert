import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/watchlist.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tvseries_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTVSeries,
  GetWatchlistTVSeriesStatus,
  SaveWatchlistTVSeries,
  RemoveWatchlistTVSeries,
])
void main() {
  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MockGetWatchlistTVSeries getWatchlistTVSeries;
  late MockGetWatchlistTVSeriesStatus getWatchlistTVSeriesStatus;
  late MockSaveWatchlistTVSeries saveTVSeriesList;
  late MockRemoveWatchlistTVSeries removeTVSerieslist;
  late TVSeriesWatchlistBloc watchlistBloc;

  setUp(() {
    getWatchlistTVSeries = MockGetWatchlistTVSeries();
    getWatchlistTVSeriesStatus = MockGetWatchlistTVSeriesStatus();
    saveTVSeriesList = MockSaveWatchlistTVSeries();
    removeTVSerieslist = MockRemoveWatchlistTVSeries();
    watchlistBloc = TVSeriesWatchlistBloc(
      getWatchlistTVSeries,
      getWatchlistTVSeriesStatus,
      saveTVSeriesList,
      removeTVSerieslist,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, TVSeriesWatchlistInitial());
  });

  group(
    'this test for get watchlist tv, ',
    () {
      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistTVSeries.execute())
              .thenAnswer((_) async => Right([testWatchlistTVSeries]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchTVSeriesWatchlist()),
        expect: () => [
          TVSeriesWatchlistLoading(),
          TVSeriesWatchlistHasData([testWatchlistTVSeries]),
        ],
        verify: (bloc) {
          verify(getWatchlistTVSeries.execute());
          return OnFetchTVSeriesWatchlist().props;
        },
      );

      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistTVSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchTVSeriesWatchlist()),
        expect: () => [
          TVSeriesWatchlistLoading(),
          TVSeriesWatchlistError('Server Failure'),
        ],
        verify: (bloc) => TVSeriesWatchlistLoading(),
      );

      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistTVSeries.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchTVSeriesWatchlist()),
        expect: () => [
          TVSeriesWatchlistLoading(),
          TVSeriesWatchlistEmpty(),
        ],
      );
    },
  );

  group(
    'this test for get watchlist status,',
    () {
      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should get true when the watchlist status is true',
        build: () {
          when(getWatchlistTVSeries.execute(testTVSeriesDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(FetchTVSeriesWatchlistStatus(testTVSeriesDetail.id)),
        expect: () => [
          TVSeriesIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistTVSeries.execute(testTVSeriesDetail.id));
          return FetchTVSeriesWatchlistStatus(testTVSeriesDetail.id).props;
        },
      );

      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should get false when the watchlist status is false',
        build: () {
          when(getWatchlistTVSeries.execute(testTVSeriesDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(FetchTVSeriesWatchlistStatus(testTVSeriesDetail.id)),
        expect: () => [
          TVSeriesIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistTVSeries.execute(testTVSeriesDetail.id));
          return FetchTVSeriesWatchlistStatus(testTVSeriesDetail.id).props;
        },
      );
    },
  );

  group(
    'this test for add and remove watchlist,',
    () {
      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveTVSeriesList.execute(testTVSeriesDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTVSeriesToWatchlist(testTVSeriesDetail)),
        expect: () => [
          TVSeriesWatchlistMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveTVSeriesList.execute(testTVSeriesDetail));
          return AddTVSeriesToWatchlist(testTVSeriesDetail).props;
        },
      );

      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveTVSeriesList.execute(testTVSeriesDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTVSeriesToWatchlist(testTVSeriesDetail)),
        expect: () => [
          TVSeriesWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveTVSeriesList.execute(testTVSeriesDetail));
          return AddTVSeriesToWatchlist(testTVSeriesDetail).props;
        },
      );

      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeTVSerieslist.execute(testTVSeriesDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveTVSeriesFromWatchlist(testTVSeriesDetail)),
        expect: () => [
          TVSeriesWatchlistMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeTVSerieslist.execute(testTVSeriesDetail));
          return RemoveTVSeriesFromWatchlist(testTVSeriesDetail).props;
        },
      );

      blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeTVSerieslist.execute(testTVSeriesDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveTVSeriesFromWatchlist(testTVSeriesDetail)),
        expect: () => [
          TVSeriesWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeTVSerieslist.execute(testTVSeriesDetail));
          return RemoveTVSeriesFromWatchlist(testTVSeriesDetail).props;
        },
      );
    },
  );
}
