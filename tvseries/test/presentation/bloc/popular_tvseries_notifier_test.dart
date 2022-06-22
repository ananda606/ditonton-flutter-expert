import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetPopularTVShows usecase;
  late TvPopularBloc tvBloc;

  setUp(() {
    usecase = MockGetPopularTVShows();
    tvBloc = TvPopularBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TvPopularEmpty());
  });

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTVList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvPopularCalled()),
    expect: () => [
      TvPopularLoading(),
      TvPopularHasData(testTVList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnTvPopularCalled().props;
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvPopularCalled()),
    expect: () => [
      TvPopularLoading(),
      TvPopularError('Server Failure'),
    ],
    verify: (bloc) => TvPopularLoading(),
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvPopularCalled()),
    expect: () => [
      TvPopularLoading(),
      TvPopularEmpty(),
    ],
  );
}
