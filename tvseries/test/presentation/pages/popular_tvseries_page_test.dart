import 'package:tvseries/tvseries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'test/test_helper.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late FakeTVSeriesPopularBloc fakeBloc;

  setUp(() {
    registerFallbackValue(FakeTVSeriesPopularEvent());
    registerFallbackValue(FakeTVSeriesPopularState());
    fakeBloc = FakeTVSeriesPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesPopularBloc>(
      create: (context) => fakeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TVSeriesPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeBloc.state)
        .thenReturn(TVSeriesPopularHasData(testTVSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TVSeriesPopularError('error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TVSeriesPopularEmpty());

    final textFinder = find.byKey(const Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
