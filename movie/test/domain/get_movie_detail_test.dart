import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieDetail getDetailMovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getDetailMovie = GetMovieDetail(mockMovieRepository);
  });

  const testId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(testId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    // act
    final result = await getDetailMovie.execute(testId);
    // assert
    expect(result, const Right(testMovieDetail));
  });
}
