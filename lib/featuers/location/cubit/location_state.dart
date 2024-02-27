part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class GetLocationInitialState extends LocationState {}

final class GetLocationSuccessState extends LocationState {
  final Position currentPosition;

  const GetLocationSuccessState({required this.currentPosition});
  @override
  List<Object> get props => [currentPosition];
}

final class GetLocationErrorState extends LocationState {
  final String error;

  const GetLocationErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
