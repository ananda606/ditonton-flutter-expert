import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVSeries usecase;
  late MockTVSeriesRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVSeriesRepository();
    usecase = SearchTVSeries(mockTvRepository);
  });

  final tTvs = <TVSeries>[];
  final tQuery = 'Spiderman';

  test('should get list of TVSeries from the repository', () async {
    // arrange
    when(mockTvRepository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvs));
  });
}