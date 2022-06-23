import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:watchlist/watchlist.dart';
import 'package:movie/movie.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:core/core.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeHome extends StatelessWidget {
  const FakeHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeHome'),
        onTap: () {
          Navigator.pushNamed(context, '/next');
        },
      ),
      appBar: AppBar(
        title: const Text('fakeHome'),
        leading: const Icon(Icons.menu),
      ),
    );
  }
}

class FakeDestination extends StatelessWidget {
  const FakeDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeDestination'),
        onTap: () {
          Navigator.pop(context);
        },
        title: const Text('fake Destination'),
        leading: const Icon(Icons.check),
      ),
    );
  }
}

MaterialApp testableMaterialApp(routes, page) {
  return MaterialApp(
    theme: ThemeData.dark().copyWith(
      colorScheme: kColorScheme,
      primaryColor: kRichBlack,
      scaffoldBackgroundColor: kRichBlack,
      textTheme: kTextTheme,
    ),
    home: page,
  );
}

/// movie list fake
class FakeMovieListEvent extends Fake implements MovieListEvent {}

class FakeMovieListState extends Fake implements MovieListState {}

class FakeMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

/// popular movie fake
class FakePopularMovieEvent extends Fake implements MoviePopularEvent {}

class FakePopularMovieState extends Fake implements MoviePopularState {}

class FakePopularMovieBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

/// top rated movie fake
class FakeTopRatedMovieEvent extends Fake implements MovieTopRatedEvent {}

class FakeTopRatedMovieState extends Fake implements MovieTopRatedState {}

class FakeTopRatedMovieBloc
    extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

/// detail movie fake
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

/// recommendation movie fake
class FakeRecommendationMovieEvent extends Fake
    implements MovieRecommendationEvent {}

class FakeRecommendationMovieState extends Fake
    implements MovieRecommendationState {}

class FakeRecommendationMovieBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

/// watchlist movie fake
class FakeMovieWatchlistEvent extends Fake implements MovieWatchlistEvent {}

class FakeMovieWatchlistState extends Fake implements MovieWatchlistState {}

class FakeMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

void main() {
  late FakeMovieListBloc fakeMovieListBloc;
  late FakePopularMovieBloc fakePopularMovieBloc;
  late FakeTopRatedMovieBloc fakeTopRatedMovieBloc;

  setUp(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    fakeMovieListBloc = FakeMovieListBloc();

    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    fakePopularMovieBloc = FakePopularMovieBloc();

    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
    fakeTopRatedMovieBloc = FakeTopRatedMovieBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => fakeTopRatedMovieBloc,
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
        BlocProvider<MovieListBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(HomeMoviePage()),
    MovieDetailPage.ROUTE_NAME: (context) => const FakeDestination(),
    TopRatedMoviesPage.ROUTE_NAME: (context) => const FakeDestination(),
    PopularMoviesPage.ROUTE_NAME: (context) => const FakeDestination(),
    SearchPage.ROUTE_NAME: (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularLoading());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(MovieTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview movielist when hasdata',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);
    final movieListFinder = find.byType(MovieList);

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(movieListFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListError('error'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularError('error'));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedError('error'));

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('Page should display empty text when empty', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListEmpty());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularEmpty());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(MovieTopRatedEmpty());

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });

  testWidgets('Tapping on see more (popular) should go to Popular page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsOneWidget);
    expect(find.byKey(const Key('see_more_popular')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('see_more_popular')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping on see more (top rated) should go to top rated page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsOneWidget);
    expect(find.byKey(const Key('see_more_popular')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('see_more_top_rated')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping on now playing card should go to movie detail page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('now_play_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping on popular card should go to movie detail page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('popular_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping on top rated card should go to movie detail page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('top_rated_0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('top_rated_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping search icon should go to movie searchPage',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byIcon(Icons.search));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });
}
