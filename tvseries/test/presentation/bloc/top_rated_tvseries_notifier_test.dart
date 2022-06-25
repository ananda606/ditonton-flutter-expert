import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TVSeriesTopRatedBloc tvSeriesBloc;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    tvSeriesBloc = TVSeriesTopRatedBloc(mockGetTopRatedTVSeries);
  });

  test('initial state should be empty', () {
    expect(tvSeriesBloc.state, TVSeriesTopRatedEmpty());
  });

  blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
    'emit loading and has data when data is success',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvSeriesBloc;
    },
    act: (blocAct) => blocAct.add(OnTVSeriesTopRatedCalled()),
    expect: () => [
      TVSeriesTopRatedLoading(),
      TVSeriesTopRatedHasData(testTVSeriesList),
    ],
    verify: (blocAct) {
      verify(mockGetTopRatedTVSeries.execute());
      return OnTVSeriesTopRatedCalled().props;
    },
  );

  blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
    'emit loading and error when data unsuccessfull',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesBloc;
    },
    act: (blocAct) => blocAct.add(OnTVSeriesTopRatedCalled()),
    expect: () => [
      TVSeriesTopRatedLoading(),
      TVSeriesTopRatedError('Server Failure'),
    ],
    verify: (blocAct) => TVSeriesTopRatedLoading(),
  );

  blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvSeriesBloc;
    },
    act: (blocAct) => blocAct.add(OnTVSeriesTopRatedCalled()),
    expect: () => [
      TVSeriesTopRatedLoading(),
      TVSeriesTopRatedEmpty(),
    ],
  );
}
