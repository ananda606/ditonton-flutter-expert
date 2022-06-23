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
  late MockGetTopRatedTVSeries usecase;
  late TVSeriesTopRatedBloc tvBloc;

  setUp(() {
    usecase = MockGetTopRatedTVSeries();
    tvBloc = TVSeriesTopRatedBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TVSeriesTopRatedEmpty());
  });

  blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTVSeriesList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesTopRatedCalled()),
    expect: () => [
      TVSeriesTopRatedLoading(),
      TVSeriesTopRatedHasData(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnTVSeriesTopRatedCalled().props;
    },
  );

  blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesTopRatedCalled()),
    expect: () => [
      TVSeriesTopRatedLoading(),
      TVSeriesTopRatedError('Server Failure'),
    ],
    verify: (bloc) => TVSeriesTopRatedLoading(),
  );

  blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesTopRatedCalled()),
    expect: () => [
      TVSeriesTopRatedLoading(),
      TVSeriesTopRatedEmpty(),
    ],
  );
}
