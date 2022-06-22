part of 'search_tvseries_bloc.dart';

@immutable
abstract class SearchTVSeriesEvent extends Equatable {}

class OnQueryTVSeriesChange extends SearchTVSeriesEvent {
  final String query;

  OnQueryTVSeriesChange(this.query);

  @override
  List<Object> get props => [query];
}
