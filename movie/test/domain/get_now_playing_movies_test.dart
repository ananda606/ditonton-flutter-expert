import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingMovies getNowPlayingmovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getNowPlayingmovie = GetNowPlayingMovies(mockMovieRepository);
  });
  final testMovies = <Movie>[];

  test('should get list of movies from the repository', () async {
    when(mockMovieRepository.getNowPlayingMovies())
        .thenAnswer((_) async => Right(testMovies));
    final result = await getNowPlayingmovie.execute();

    expect(result, Right(testMovies));
  });
}
