part of 'movie_popular_bloc.dart';

@immutable
abstract class MoviePopularEvent extends Equatable {}

class MoviePopularCalled extends MoviePopularEvent {
  @override
  List<Object> get props => [];
}
