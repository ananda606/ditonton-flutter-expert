import 'package:core/core.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertWatchlist(TVSeriesTable tvseries);
  Future<String> removeWatchlist(TVSeriesTable tvseries);
  Future<TVSeriesTable?> getTVSeriesById(int id);
  Future<List<TVSeriesTable>> getWatchlistTVSeries();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelperTVSeries databaseHelper;

  TVSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TVSeriesTable tvseries) async {
    try {
      await databaseHelper.insertWatchlist(tvseries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVSeriesTable tvseries) async {
    try {
      await databaseHelper.removeWatchlist(tvseries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVSeriesTable?> getTVSeriesById(int id) async {
    final result = await databaseHelper.getTVSeriesById(id);
    if (result != null) {
      return TVSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVSeriesTable>> getWatchlistTVSeries() async {
    final result = await databaseHelper.getWatchlistTVSeries();
    return result.map((data) => TVSeriesTable.fromMap(data)).toList();
  }
}
