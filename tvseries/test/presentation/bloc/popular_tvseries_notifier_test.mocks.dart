// Mocks generated by Mockito 5.2.0 from annotations
// in tvseries/test/presentation/bloc/popular_tvseries_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i2;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tvseries/domain/tvseries/get_popular_tvseries.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTVSeriesRepository_0 extends _i1.Fake
    implements _i2.TVSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetPopularTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTVSeries extends _i1.Mock
    implements _i4.GetPopularTVSeries {
  MockGetPopularTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i2.Failure, List<_i2.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i2.Failure, List<_i2.TVSeries>>>.value(
                      _FakeEither_1<_i2.Failure, List<_i2.TVSeries>>()))
          as _i5.Future<_i3.Either<_i2.Failure, List<_i2.TVSeries>>>);
}
