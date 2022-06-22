import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRpository;

  setUp(() {
    mockTVSeriesRpository = MockTVSeriesRepository();
    usecase = GetPopularTVSeries(mockTVSeriesRpository);
  });

  final ttvSeries = <TVSeries>[];

  group('GetPopularTVSeries Tests', () {
    group('execute', () {
      test(
          'should get list of tvseries from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVSeriesRpository.getPopularTVSeries())
            .thenAnswer((_) async => Right(ttvSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(ttvSeries));
      });
    });
  });
}
