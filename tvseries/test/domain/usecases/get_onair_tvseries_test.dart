import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTVSeries usecase;
  late MockTVSeriesRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVSeriesRepository();
    usecase = GetOnAirTVSeries(mockTvRepository);
  });

  final tTvs = <TVSeries>[];

  test('should get list of TVSeries from the repository', () async {
    // arrange
    when(mockTvRepository.getOnAirTVSeries())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
