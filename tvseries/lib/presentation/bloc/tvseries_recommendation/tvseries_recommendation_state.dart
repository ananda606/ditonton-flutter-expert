part of 'tvseries_recommendation_bloc.dart';

@immutable
abstract class TVSeriesRecommendationState extends Equatable {}

class TVSeriesRecommendationEmpty extends TVSeriesRecommendationState {
  @override
  List<Object?> get props => [];
}

class TVSeriesRecommendationLoading extends TVSeriesRecommendationState {
  @override
  List<Object?> get props => [];
}

class TVSeriesRecommendationError extends TVSeriesRecommendationState {
  final String message;

  TVSeriesRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}

class TVSeriesRecommendationHasData extends TVSeriesRecommendationState {
  final List<TVSeries> result;

  TVSeriesRecommendationHasData(this.result);

  @override
  List<Object?> get props => [];
}
