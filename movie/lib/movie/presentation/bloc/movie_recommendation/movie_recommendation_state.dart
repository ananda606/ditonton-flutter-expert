part of 'movie_recommendation_bloc.dart';

@immutable
abstract class MovieRecommendationState extends Equatable {}

class MovieRecommendationLoading extends MovieRecommendationState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationHasData extends MovieRecommendationState {
  final List<Movie> result;

  MovieRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationEmpty extends MovieRecommendationState {
  @override
  List<Object> get props => [];
}
