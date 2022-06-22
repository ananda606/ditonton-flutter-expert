part of 'tvseries_list_bloc.dart';

@immutable
abstract class TVSeriesListState extends Equatable {}

class TVSeriesListEmpty extends TVSeriesListState {
  @override
  List<Object?> get props => [];
}

class TVSeriesListLoading extends TVSeriesListState {
  @override
  List<Object?> get props => [];
}

class TVSeriesListError extends TVSeriesListState {
  final String message;

  TVSeriesListError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesListHasData extends TVSeriesListState {
  final List<TVSeries> result;

  TVSeriesListHasData(this.result);

  @override
  List<Object?> get props => [result];
}
