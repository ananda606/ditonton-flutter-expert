import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'test_helper/test_helper.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  late FakeMovieListBloc fakeMovieListBloc;
  late FakePopularMovieBloc fakeMoviePopularBloc;
  late FakeTopRatedMovieBloc fakeMovieTopBloc;

  setUp(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    fakeMovieListBloc = FakeMovieListBloc();

    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    fakeMoviePopularBloc = FakePopularMovieBloc();

    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
    fakeMovieTopBloc = FakeTopRatedMovieBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakeMoviePopularBloc,
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => fakeMovieTopBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListLoading());
    when(() => fakeMoviePopularBloc.state).thenReturn(MoviePopularLoading());
    when(() => fakeMovieTopBloc.state).thenReturn(MovieTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview tvlist when hasdata',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakeMoviePopularBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeMovieTopBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);
    final tvListFinder = find.byType(MovieList);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(tvListFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListError('error'));
    when(() => fakeMoviePopularBloc.state)
        .thenReturn(MoviePopularError('error'));
    when(() => fakeMovieTopBloc.state).thenReturn(MovieTopRatedError('error'));

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('Page should display empty text when empty', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListEmpty());
    when(() => fakeMoviePopularBloc.state).thenReturn(MoviePopularEmpty());
    when(() => fakeMovieTopBloc.state).thenReturn(MovieTopRatedEmpty());

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });
}
