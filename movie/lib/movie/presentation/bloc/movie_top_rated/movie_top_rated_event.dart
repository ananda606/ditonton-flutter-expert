part of 'movie_top_rated_bloc.dart';

@immutable
abstract class MovieTopRatedEvent extends Equatable {}

class MovieTopRatedCalled extends MovieTopRatedEvent {
  @override
  List<Object> get props => [];
}
