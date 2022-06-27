import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tvseries/tvseries.dart';
import 'test/test_helper.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  late FakeTVSeriesListBloc fakeTVSeriesListBloc;
  late FakeTVSeriesPopularBloc fakeTVSeriesPopularBloc;
  late FakeTVSeriesTopBloc fakeTVSeriesTopBloc;

  setUp(() {
    registerFallbackValue(FakeTVSeriesListEvent());
    registerFallbackValue(FakeTVSeriesListState());
    fakeTVSeriesListBloc = FakeTVSeriesListBloc();

    registerFallbackValue(FakeTVSeriesPopularEvent());
    registerFallbackValue(FakeTVSeriesPopularState());
    fakeTVSeriesPopularBloc = FakeTVSeriesPopularBloc();

    registerFallbackValue(FakeTVSeriesTopEvent());
    registerFallbackValue(FakeTVSeriesTopState());
    fakeTVSeriesTopBloc = FakeTVSeriesTopBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesListBloc>(
          create: (context) => fakeTVSeriesListBloc,
        ),
        BlocProvider<TVSeriesPopularBloc>(
          create: (context) => fakeTVSeriesPopularBloc,
        ),
        BlocProvider<TVSeriesTopRatedBloc>(
          create: (context) => fakeTVSeriesTopBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesListBloc>(
          create: (context) => fakeTVSeriesListBloc,
        ),
        BlocProvider<TVSeriesPopularBloc>(
          create: (context) => fakeTVSeriesPopularBloc,
        ),
        BlocProvider<TVSeriesTopRatedBloc>(
          create: (context) => fakeTVSeriesTopBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(HomeTVSeriesPage()),
    TVSeriesDetailPage.ROUTE_NAME: (context) => const FakeDestination(),
    TopRatedTVSeriesPage.ROUTE_NAME: (context) => const FakeDestination(),
    PopularTVSeriesPage.ROUTE_NAME: (context) => const FakeDestination(),
    SearchPage.ROUTE_NAME: (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeTVSeriesListBloc.state).thenReturn(TVSeriesListLoading());
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(TVSeriesPopularLoading());
    when(() => fakeTVSeriesTopBloc.state).thenReturn(TVSeriesTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(HomeTVSeriesPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview tvlist when hasdata',
      (tester) async {
    when(() => fakeTVSeriesListBloc.state)
        .thenReturn(TVSeriesListHasData(testTVSeriesList));
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(TVSeriesPopularHasData(testTVSeriesList));
    when(() => fakeTVSeriesTopBloc.state)
        .thenReturn(TVSeriesTopRatedHasData(testTVSeriesList));

    final listViewFinder = find.byType(ListView);
    final tvListFinder = find.byType(TVSeriesList);

    await tester.pumpWidget(_createTestableWidget(HomeTVSeriesPage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(tvListFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeTVSeriesListBloc.state)
        .thenReturn(TVSeriesListError('error'));
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(TVSeriesPopularError('error'));
    when(() => fakeTVSeriesTopBloc.state)
        .thenReturn(TVSeriesTopRatedError('error'));

    await tester.pumpWidget(_createTestableWidget(HomeTVSeriesPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('Page should display empty text when empty', (tester) async {
    when(() => fakeTVSeriesListBloc.state).thenReturn(TVSeriesListEmpty());
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(TVSeriesPopularEmpty());
    when(() => fakeTVSeriesTopBloc.state).thenReturn(TVSeriesTopRatedEmpty());

    await tester.pumpWidget(_createTestableWidget(HomeTVSeriesPage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });
}
