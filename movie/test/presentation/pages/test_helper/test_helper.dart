import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';

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
  setUp(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());

    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());

    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });
}
