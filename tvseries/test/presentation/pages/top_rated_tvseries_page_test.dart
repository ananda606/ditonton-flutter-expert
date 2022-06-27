import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../dummy_data/dummy_objects.dart';
import 'test/test_helper.dart';

void main() {
  late FakeTVSeriesTopBloc fakeBloc;

  setUp(() {
    registerFallbackValue(FakeTVSeriesTopEvent());
    registerFallbackValue(FakeTVSeriesTopState());
    fakeBloc = FakeTVSeriesTopBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<TVSeriesTopRatedBloc>(
      create: (context) => fakeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<TVSeriesTopRatedBloc>(
      create: (context) => fakeBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(TopRatedTVSeriesPage()),
    TVSeriesDetailPage.ROUTE_NAME: (context) => FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TVSeriesTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_createTestableWidget(TopRatedTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeBloc.state)
        .thenReturn(TVSeriesTopRatedHasData(testTVSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(TopRatedTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TVSeriesTopRatedError('error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(TopRatedTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TVSeriesTopRatedEmpty());

    final textFinder = find.byKey(Key('empty_message'));

    await tester.pumpWidget(_createTestableWidget(TopRatedTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
