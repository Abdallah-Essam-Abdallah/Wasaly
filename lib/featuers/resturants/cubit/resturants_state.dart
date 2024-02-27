part of 'resturants_cubit.dart';

sealed class ResturantsState extends Equatable {
  const ResturantsState();

  @override
  List<Object> get props => [];
}

final class ResturantsInitial extends ResturantsState {}

final class GetResturantsLoadingState extends ResturantsState {}

final class GetResturantsLoadedState extends ResturantsState {
  final List<ResturantModel> resturants;

  const GetResturantsLoadedState({required this.resturants});

  @override
  List<Object> get props => [resturants];
}

final class GetResturantsErrorState extends ResturantsState {
  final String error;

  const GetResturantsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetResturantMenuLoadingState extends ResturantsState {}

final class GetResturantMenuLoadedState extends ResturantsState {
  final List<MenuItemModel> menuItems;

  const GetResturantMenuLoadedState({required this.menuItems});

  @override
  List<Object> get props => [menuItems];
}

final class GetResturantMenuErrorState extends ResturantsState {
  final String error;

  const GetResturantMenuErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
