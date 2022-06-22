part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListState extends Equatable {}

class MovieListEmpty extends MovieListState {
  @override
  List<Object> get props => [];
}

class MovieListLoading extends MovieListState {
  @override
  List<Object> get props => [];
}

class MovieListError extends MovieListState {
  final String message;

  MovieListError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasData extends MovieListState {
  final List<Movie> result;

  MovieListHasData(this.result);

  @override
  List<Object> get props => [result];
}
