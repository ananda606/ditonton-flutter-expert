part of 'tvseries_detail_bloc.dart';

@immutable
abstract class TVSeriesDetailState extends Equatable {}

class TVSeriesDetailEmpty extends TVSeriesDetailState {
  @override
  List<Object?> get props => [];
}

class TVSeriesDetailLoading extends TVSeriesDetailState {
  @override
  List<Object?> get props => [];
}

class TVSeriesDetailError extends TVSeriesDetailState {
  final String message;

  TVSeriesDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class TVSeriesDetailHasData extends TVSeriesDetailState {
  final TVSeriesDetail result;

  TVSeriesDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}
