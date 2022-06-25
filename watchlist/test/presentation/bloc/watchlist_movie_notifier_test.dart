import 'package:dartz/dartz.dart';
import 'package:watchlist/watchlist.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
])
void main() {
  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MockGetWatchlistMovies getWatchlistMovies;
  late MockGetWatchListStatus getWatchlistStatus;
  late MockRemoveWatchlist removeWatchlist;
  late MockSaveWatchlist saveWatchlist;
  late MovieWatchlistBloc watchlistBloc;

  setUp(() {
    getWatchlistMovies = MockGetWatchlistMovies();
    getWatchlistStatus = MockGetWatchListStatus();
    removeWatchlist = MockRemoveWatchlist();
    saveWatchlist = MockSaveWatchlist();
    watchlistBloc = MovieWatchlistBloc(
      getWatchlistMovies,
      getWatchlistStatus,
      removeWatchlist,
      saveWatchlist,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, MovieWatchlistInitial());
  });

  group(
    'this test for get watchlist movies,',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(getWatchlistMovies.execute());
          return OnFetchMovieWatchlist().props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistError('Server Failure'),
        ],
        verify: (bloc) => MovieWatchlistLoading(),
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistEmpty(),
        ],
      );
    },
  );

  group(
    'this test for get watchlist status,',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should get true when the watchlist status is true',
        build: () {
          when(getWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
        expect: () => [
          MovieIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testMovieDetail.id));
          return FetchWatchlistStatus(testMovieDetail.id).props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should get false when the watchlist status is false',
        build: () {
          when(getWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
        expect: () => [
          MovieIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testMovieDetail.id));
          return FetchWatchlistStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group(
    'this test for add and remove watchlist,',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );
    },
  );
}
