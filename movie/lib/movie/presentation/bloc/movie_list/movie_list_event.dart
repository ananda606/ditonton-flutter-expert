part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListEvent extends Equatable {}

class OnMovieListCalled extends MovieListEvent {
  @override
  List<Object> get props => [];
}
