part of 'ability_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends DataEvent {}

class LoadMoreData extends DataEvent {}
