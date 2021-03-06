import 'package:dartz/dartz.dart';
import 'package:watchlist/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = RemoveWatchlistTVSeries(mockTVSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTVSeriesRepository.removeWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockTVSeriesRepository.removeWatchlist(testTVSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
