part of 'tvseries_recommendation_bloc.dart';

@immutable
abstract class TVSeriesRecommendationEvent extends Equatable {}

class OnTVSeriesRecommendationCalled extends TVSeriesRecommendationEvent {
  final int id;

  OnTVSeriesRecommendationCalled(this.id);

  @override
  List<Object?> get props => [id];
}
