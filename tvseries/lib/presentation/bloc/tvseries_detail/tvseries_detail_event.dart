part of 'tvseries_detail_bloc.dart';

@immutable
abstract class TVSeriesDetailEvent extends Equatable {}

class OnTVSeriesDetailCalled extends TVSeriesDetailEvent {
  final int id;

  OnTVSeriesDetailCalled(this.id);

  @override
  List<Object?> get props => [id];
}
