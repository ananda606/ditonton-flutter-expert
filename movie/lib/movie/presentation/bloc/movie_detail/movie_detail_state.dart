part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState extends Equatable {}

class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;

  MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailEmpty extends MovieDetailState {
  @override
  List<Object> get props => [];
}
