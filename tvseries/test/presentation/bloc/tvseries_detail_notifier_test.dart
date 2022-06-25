import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import 'package:bloc_test/bloc_test.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendations,
])
void main() {
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late TVSeriesDetailBloc tvSeriesBloc;

  const tId = 1;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    tvSeriesBloc = TVSeriesDetailBloc(mockGetTVSeriesDetail);
  });

  test('initial state should be empty', () {
    expect(tvSeriesBloc.state, TVSeriesDetailEmpty());
  });

  blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesBloc;
    },
    act: (blocAct) => blocAct.add(OnTVSeriesDetailCalled(tId)),
    expect: () => [
      TVSeriesDetailLoading(),
      TVSeriesDetailError('Server Failure'),
    ],
    verify: (blocAct) => TVSeriesDetailLoading(),
  );
}
