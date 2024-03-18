part of 'ability_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class DataInitial extends DataState {}

class DataLoaded extends DataState {
  final List<loadapi> datas;
  final bool hasMoreData;
  final bool isLoading;

  const DataLoaded({
    required this.datas,
    required this.hasMoreData,
    required this.isLoading,
  }) : super();

  @override
  List<Object?> get props => [datas, hasMoreData, isLoading];
}

class DataError extends DataState {
  final String errorMessage;

  const DataError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
