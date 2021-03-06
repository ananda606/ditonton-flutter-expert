import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesDetail(mockTVSeriesRepository);
  });

  const tId = 1;

  test('should get tvseries detail from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTVSeriesDetail(tId))
        .thenAnswer((_) async => const Right(testTVSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testTVSeriesDetail));
  });
}
