import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetMovieDetail {
  final MovieRepository repository;
  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
