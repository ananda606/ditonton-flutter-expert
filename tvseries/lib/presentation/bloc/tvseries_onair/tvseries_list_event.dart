part of 'tvseries_list_bloc.dart';

@immutable
abstract class TVSeriesListEvent extends Equatable {}

class OnTVSeriesListCalled extends TVSeriesListEvent {
  @override
  List<Object?> get props => [];
}
