import 'package:tvseries/tvseries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/watchlist.dart';
import 'test/test_helper.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

void main() {
  late FakeTVSeriesDetailBloc fakeTVBloc;
  late FakeTVSeriesWatchlistBloc fakeWatchlistBloc;
  late FakeTVSeriesRecomBloc fakeRecomBloc;

  setUpAll(() {
    registerFallbackValue(FakeTVSeriesDetailEvent());
    registerFallbackValue(FakeTVSeriesDetailState());
    fakeTVBloc = FakeTVSeriesDetailBloc();

    registerFallbackValue(FakeTVSeriesWatchlistEvent());
    registerFallbackValue(FakeTVSeriesWatchlistState());
    fakeWatchlistBloc = FakeTVSeriesWatchlistBloc();

    registerFallbackValue(FakeTVSeriesRecomEvent());
    registerFallbackValue(FakeTVSeriesRecomState());
    fakeRecomBloc = FakeTVSeriesRecomBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesDetailBloc>(
          create: (context) => fakeTVBloc,
        ),
        BlocProvider<TVSeriesWatchlistBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<TVSeriesRecommendationBloc>(
          create: (context) => fakeRecomBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesDetailBloc>(
          create: (context) => fakeTVBloc,
        ),
        BlocProvider<TVSeriesWatchlistBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<TVSeriesRecommendationBloc>(
          create: (context) => fakeRecomBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) =>
        _makeAnotherTestableWidget(const TVSeriesDetailPage(id: 1)),
    TVSeriesDetailPage.ROUTE_NAME: (context) => const FakeDestination(),
  };

  testWidgets('should show circular progress when TV detail is loading',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TVSeriesDetailLoading());
    when(() => fakeRecomBloc.state).thenReturn(TVSeriesRecommendationLoading());

    when(() => fakeWatchlistBloc.state)
        .thenReturn(TVSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(TVSeriesDetailPage(id: testTVSeriesDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message progress when TV detail is error',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TVSeriesDetailError('error'));
    when(() => fakeRecomBloc.state).thenReturn(TVSeriesRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(TVSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(TVSeriesDetailPage(id: testTVSeriesDetail.id)));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('should show empty message progress when TV detail is empty',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TVSeriesDetailEmpty());
    when(() => fakeRecomBloc.state).thenReturn(TVSeriesRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(TVSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(TVSeriesDetailPage(id: testTVSeriesDetail.id)));

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when TV not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTVBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTVSeriesDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TVSeriesRecommendationHasData(testTVSeriesList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(TVSeriesIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        _makeTestableWidget(TVSeriesDetailPage(id: testTVSeriesDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when TV is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeTVBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTVSeriesDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TVSeriesRecommendationHasData(testTVSeriesList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(TVSeriesIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        _makeTestableWidget(TVSeriesDetailPage(id: testTVSeriesDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('should show error text when TV recom is error', (tester) async {
    when(() => fakeTVBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTVSeriesDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TVSeriesRecommendationError('error'));

    when(() => fakeWatchlistBloc.state)
        .thenReturn(TVSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(TVSeriesDetailPage(id: testTVSeriesDetail.id)));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('should show Container when TV recom is empty', (tester) async {
    when(() => fakeTVBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTVSeriesDetail));
    when(() => fakeRecomBloc.state).thenReturn(TVSeriesRecommendationEmpty());

    when(() => fakeWatchlistBloc.state)
        .thenReturn(TVSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(TVSeriesDetailPage(id: testTVSeriesDetail.id)));

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
  });

  testWidgets(
    "should back to previous page when arrow back icon was clicked",
    (WidgetTester tester) async {
      when(() => fakeTVBloc.state)
          .thenReturn(TVSeriesDetailHasData(testTVSeriesDetail));
      when(() => fakeRecomBloc.state)
          .thenReturn(TVSeriesRecommendationHasData(testTVSeriesList));

      when(() => fakeWatchlistBloc.state)
          .thenReturn(TVSeriesIsAddedToWatchlist(false));

      await tester.pumpWidget(MaterialApp(
        routes: routes,
      ));

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byKey(const Key('fakeHome')), findsNothing);

      await tester.tap(find.byIcon(Icons.arrow_back));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsNothing);
    },
  );
}
