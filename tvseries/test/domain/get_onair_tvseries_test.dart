import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetOnAirTVSeries(mockTVSeriesRepository);
  });

  final tTVSeriess = <TVSeries>[];

  test('should get list of TVSeries from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getOnAirTVSeries())
        .thenAnswer((_) async => Right(tTVSeriess));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVSeriess));
  });
}
