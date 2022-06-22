part of 'tvseries_top_rated_bloc.dart';

@immutable
abstract class TVSeriesTopRatedState extends Equatable {}

class TVSeriesTopRatedEmpty extends TVSeriesTopRatedState {
  @override
  List<Object?> get props => [];
}

class TVSeriesTopRatedLoading extends TVSeriesTopRatedState {
  @override
  List<Object?> get props => [];
}

class TVSeriesTopRatedError extends TVSeriesTopRatedState {
  final String message;

  TVSeriesTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class TVSeriesTopRatedHasData extends TVSeriesTopRatedState {
  final List<TVSeries> result;

  TVSeriesTopRatedHasData(this.result);

  @override
  List<Object?> get props => [];
}
