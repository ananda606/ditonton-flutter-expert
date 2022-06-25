part of 'movie_top_rated_bloc.dart';

@immutable
abstract class MovieTopRatedState extends Equatable {}

class MovieTopRatedLoading extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedEmpty extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}
