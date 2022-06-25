part of 'movie_recommendation_bloc.dart';

@immutable
abstract class MovieRecommendationEvent extends Equatable {}

class MovieRecommendationCalled extends MovieRecommendationEvent {
  final int id;
  MovieRecommendationCalled(this.id);
  @override
  List<Object> get props => [id];
}
