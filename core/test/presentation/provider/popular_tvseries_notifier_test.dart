import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/presentation/provider/popular_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late PopularTVSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    notifier = PopularTVSeriesNotifier(mockGetPopularTVSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = TVSeries(
    backdropPath: '/path.jpg',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <TVSeries>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTVSeries.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchPopularTVSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTVSeries.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularTVSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTVSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTVSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
