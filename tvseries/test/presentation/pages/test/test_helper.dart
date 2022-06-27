import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';

// TVSeries detail
class FakeTVSeriesDetailEvent extends Fake implements TVSeriesDetailEvent {}

class FakeTVSeriesDetailState extends Fake implements TVSeriesDetailState {}

class FakeTVSeriesDetailBloc
    extends MockBloc<TVSeriesDetailEvent, TVSeriesDetailState>
    implements TVSeriesDetailBloc {}

// TVSeries list
class FakeTVSeriesListEvent extends Fake implements TVSeriesListEvent {}

class FakeTVSeriesListState extends Fake implements TVSeriesListState {}

class FakeTVSeriesListBloc
    extends MockBloc<TVSeriesListEvent, TVSeriesListState>
    implements TVSeriesListBloc {}

// TVSeries popular
class FakeTVSeriesPopularEvent extends Fake implements TVSeriesPopularEvent {}

class FakeTVSeriesPopularState extends Fake implements TVSeriesPopularState {}

class FakeTVSeriesPopularBloc
    extends MockBloc<TVSeriesPopularEvent, TVSeriesPopularState>
    implements TVSeriesPopularBloc {}

// TVSeries recom
class FakeTVSeriesRecomEvent extends Fake
    implements TVSeriesRecommendationEvent {}

class FakeTVSeriesRecomState extends Fake
    implements TVSeriesRecommendationState {}

class FakeTVSeriesRecomBloc
    extends MockBloc<TVSeriesRecommendationEvent, TVSeriesRecommendationState>
    implements TVSeriesRecommendationBloc {}

// TVSeries top rate
class FakeTVSeriesTopEvent extends Fake implements TVSeriesTopRatedEvent {}

class FakeTVSeriesTopState extends Fake implements TVSeriesTopRatedState {}

class FakeTVSeriesTopBloc
    extends MockBloc<TVSeriesTopRatedEvent, TVSeriesTopRatedState>
    implements TVSeriesTopRatedBloc {}

// TVSeries watchlist
class FakeTVSeriesWatchlistEvent extends Fake
    implements TVSeriesWatchlistEvent {}

class FakeTVSeriesWatchlistState extends Fake
    implements TVSeriesWatchlistState {}

class FakeTVSeriesWatchlistBloc
    extends MockBloc<TVSeriesWatchlistEvent, TVSeriesWatchlistState>
    implements TVSeriesWatchlistBloc {}

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
