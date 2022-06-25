part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListEvent extends Equatable {}

class MovieListCalled extends MovieListEvent {
  @override
  List<Object> get props => [];
}
