import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieRecommendations getRecommendmovies;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getRecommendmovies = GetMovieRecommendations(mockMovieRepository);
  });

  const testId = 1;
  final testMovies = <Movie>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getMovieRecommendations(testId))
        .thenAnswer((_) async => Right(testMovies));
    // act
    final result = await getRecommendmovies.execute(testId);
    // assert
    expect(result, Right(testMovies));
  });
}
