import 'package:core/core.dart';
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
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
