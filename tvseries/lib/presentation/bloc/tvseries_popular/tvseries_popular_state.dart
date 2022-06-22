part of 'tvseries_popular_bloc.dart';

@immutable
abstract class TVSeriesPopularState extends Equatable {}

class TVSeriesPopularEmpty extends TVSeriesPopularState {
  @override
  List<Object?> get props => [];
}

class TVSeriesPopularLoading extends TVSeriesPopularState {
  @override
  List<Object?> get props => [];
}

class TVSeriesPopularError extends TVSeriesPopularState {
  final String message;

  TVSeriesPopularError(this.message);

  @override
  List<Object?> get props => [message];
}

class TVSeriesPopularHasData extends TVSeriesPopularState {
  final List<TVSeries> result;

  TVSeriesPopularHasData(this.result);

  @override
  List<Object?> get props => [];
}
