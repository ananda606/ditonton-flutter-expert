import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularMovies getPopularMovie;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    getPopularMovie = GetPopularMovies(mockMovieRpository);
  });

  final testMovies = <Movie>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        when(mockMovieRpository.getPopularMovies())
            .thenAnswer((_) async => Right(testMovies));
        final result = await getPopularMovie.execute();

        expect(result, Right(testMovies));
      });
    });
  });
}
