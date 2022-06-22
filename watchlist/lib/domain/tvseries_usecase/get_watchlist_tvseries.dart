import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetWatchlistTVSeries {
  final TVSeriesRepository repository;
  GetWatchlistTVSeries(this.repository);
  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getWatchlistTVSeries();
  }
}
