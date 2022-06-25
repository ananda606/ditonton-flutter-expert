import 'package:core/core.dart';
import 'package:watchlist/watchlist.dart';
import 'package:mockito/annotations.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  TVSeriesRepository,
  MovieRemoteDataSource,
  TVSeriesRemoteDataSource,
  MovieLocalDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelper,
  DatabaseHelperTVSeries,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
  GetWatchlistTVSeries,
  GetWatchlistTVSeriesStatus,
  RemoveWatchlistTVSeries,
  SaveWatchlistTVSeries,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SSLPinningClient>(as: #MockSSLPinning),
])
void main() {}
