part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {}

class MovieDetailCalled extends MovieDetailEvent {
  final int id;
  MovieDetailCalled(this.id);

  @override
  List<Object> get props => [id];
}
